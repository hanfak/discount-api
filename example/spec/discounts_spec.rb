require './models/discounts'

describe Discounts do
  subject { Discounts.new(
                  discount_total_amount: 0.1,
                  discount_total_minimum: 30,
                  total_express_minimum: 1,
                  express_discount: 0.75 )
          }

  describe '#initialize' do
    it 'has total discount amount of 10%' do
      expect(subject.discount_total_amount).to eq 0.1
    end

    it 'has total discount for minimum total of $30' do
      expect(subject.discount_total_minimum).to eq 30
    end
  end
# change method name
  describe '#total_cost_percentage' do
    it 'returns 1.0 for total amount 30 or less' do
      expect(subject.total_cost_percentage(25)).to eq 1.0
    end

    it 'returns 0.9 for total amount more than 30' do
      expect(subject.total_cost_percentage(35)).to eq 0.9
    end
  end

  describe '#express_delivery_percentage' do
    it 'returns 1.0 for standard delivery' do
      expect(subject.express_delivery_percentage(:standard, 1)).to eq 1.0
    end

    it 'returns 1.0 for 1 express delivery' do
      expect(subject.express_delivery_percentage(:express, 1)).to eq 1.0
    end

    it 'returns 0.75 for 2 or more express deliveries' do
      expect(subject.express_delivery_percentage(:express, 2)).to eq 0.75
    end
  end
end
