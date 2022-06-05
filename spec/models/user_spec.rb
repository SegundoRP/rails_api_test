require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'validate presence of required fields'do
      should validate_presence_of(:email)
      should validate_presence_of(:name)
      should validate_presence_of(:auth_token)
      should validate_presence_of(:user_id)
    end

    it 'Validate relations' do
      should have_many(:posts)
    end
  end
end
