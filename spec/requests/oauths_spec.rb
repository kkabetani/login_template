require 'spec_helper'

describe "OAuth" do

  subject { page }

  describe "Login" do
    
    shared_examples "welcome" do
      it { should have_content("Welcome " + user.name) }
      it { should have_link("Logout") }
    end

    shared_examples "login link" do
      it { should have_link("Twitter Login") }
      it { should have_link("Facebook Login") }
    end

    let(:user) { FactoryGirl.create(:user) }
    before do
      OmniAuth.config.test_mode = true
    end

    after do
      OmniAuth.config.test_mode = false
    end

    describe "Cancel" do
      before { visit "/auth/failure" }

      include_examples "login link"
    end

    describe "Twitter" do
      before do
        create_oauth_user(:twitter, user)
      end

      context "when Success" do
        before { visit "/auth/twitter" }

        include_examples "welcome"

        describe "Logout" do
          before { click_link "Logout" }

          include_examples "login link"
        end
      end
    end

    describe "Facebook" do
      before do
        create_oauth_user(:facebook, user)
      end

      context "when Success" do
        before { visit "/auth/facebook" }

        include_examples "welcome"

        describe "Logout" do
          before { click_link "Logout" }

          include_examples "login link"
        end
      end
    end
  end
end
