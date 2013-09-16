require 'spec_helper'

describe "OAuth" do

  subject { page }
  
  describe "Login" do
    before do
      OmniAuth.config.test_mode = true
      @user = FactoryGirl.create(:user)
    end

    after do
      OmniAuth.config.test_mode = false
    end

    describe "Twitter" do
      before do
        OmniAuth.config.mock_auth[:twitter] = {
          "uid" => @user.uid,
          "provider" => "twitter",
          "info" => {
            "name" => @user.name
          }
        }
      end

      context "when Success" do
        before do 
          visit "/auth/twitter"
        end

        it { should have_content(@user.name) }
      end
    end

    describe "Facebook" do
      before do
        OmniAuth.config.mock_auth[:facebook] = {
          "uid" => @user.uid,
          "provider" => "facebook",
          "info" => {
            "name" => @user.name
          }
        }
      end

      context "when Success" do
          before do 
            visit "/auth/facebook"
          end

          it { should have_content(@user.name) }
      end
    end
  end

end
