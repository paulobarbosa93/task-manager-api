require 'rails_helper'

RSpec.describe Authenticable do
  controller(ApplicationController) do
    include Authenticable
  end

  let(:app_controller) { subject } # in this case, subject is the controller

  describe ".current_user" do
    let(:user) { create(:user) }

    before do

    end

    it "returns the user from the Authorization header" do
      # expect(app_controller.current_user).to eq(user)
    end

  end
end
