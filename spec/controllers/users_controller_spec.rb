require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe "GET #new" do
      it "renders the new template" do 
        get :new  
        expect(response).to render_template("new")
      end 
    end

    describe "POST #create" do
      context "with invalid params" do 
        it "validates the presence of user's email and password" do 
          post :create, params: {user: {email: "cindy@cindy.com"} }
          expect(response).to render_template("new")
        end 
        
        it "validates the length of password is at least 6 long" do 
          post :create, params: { user: { email: "cindy@cindy.com", password: "ok"} } 
          expect(response).to render_template("new")
        end 
    end 
    
    context "with valid params" do 
        it "redirects user to sign in page" do
          post :create, params: { user: { email: "cindy@cindy.com", password: "password"} } 
          expect(response).to redirect_to(user_url(User.find_by(email: "cindy@cindy.com")))
         end 
      end 
    end

end
