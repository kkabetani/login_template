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
        before { visit "/auth/twitter" }

        it { should have_content("Welcome " + @user.name) }
        it { should have_link("Logout") }

        describe "Logout" do
          before { click_link "Logout" }

          it { should have_link("Twitter Login") }
          it { should have_link("Facebook Login") }
        end
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
        before { visit "/auth/facebook" }

        it { should have_content("Welcome " + @user.name) }
        it { should have_link("Logout") }

        describe "Logout" do
          before { click_link "Logout" }

          it { should have_link("Twitter Login") }
          it { should have_link("Facebook Login") }
        end
      end
    end
  end
end
