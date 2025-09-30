require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  describe 'ApplicationRecord' do
    it 'is an abstract class' do
      expect(ApplicationRecord).to be < ActiveRecord::Base
    end

    it 'is abstract' do
      expect(ApplicationRecord.abstract_class).to be true
    end
  end
end
