require 'rails_helper'

describe(User) do
  describe('do things') do
    let(:user) { FactoryBot.build(:user) }

    it('does stuff and things') do
      expect(true).to be true
    end
  end
end
