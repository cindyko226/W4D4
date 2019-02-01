require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  

  subject(:user) {User.new(email: "cindy@cindy.com", password: "password")}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_length_of(:password).is_at_least(6)}


  describe "#reset_session_token!" do 
    it "sets a new session token on the user" do 
      user.valid?
      old_session_token = user.session_token 
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_session_token) 
    end

    it "return new session token" do 
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end


  describe "#is_password?" do 
    it "varifies a password is correct" do  
      expect(user.is_password?("password")).to be true
    end 

    it "varifies a password is not correct" do 
      expect(user.is_password?("wrongpassword")).to be false 
    end 
  end

  describe ".find_by_credentials" do    
    before {user.save!}
    
    it "returns user given correct credentials" do 
      expect(User.find_by_credentials("cindy@cindy.com","password")).to eq(user)
    end 

    it "returns nil given wrong credentials" do  
      expect(User.find_by_credentials("ok@ok.com","password")).to eq(nil) 
    end
  end
    
end