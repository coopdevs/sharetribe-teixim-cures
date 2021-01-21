require 'spec_helper'

describe Transaction, type: :model do
  describe '#for_testimonials' do
    it 'includes transactions in free state' do
      free_transaction = FactoryGirl.create(:transaction, current_state: 'free')
      expect(Transaction.for_testimonials).to include(free_transaction)
    end
  end
end
