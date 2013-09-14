require 'spec_helper'

describe "Welcomes" do

  subject { page }
  
  describe "root path" do
    before { visit root_path }

    it { should have_selector('h1', text: "Login Template") }

    it { should have_selector('a', text: "Twitter Login") }
    it { should have_selector('a', text: "Facebook Login") }

  end

end
