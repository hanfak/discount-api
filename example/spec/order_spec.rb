require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'

describe Order do
  let(:discounts) { double :Discounts, discount_percentage: 0.9 }
  subject { Order.new(material, discounts) }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  context 'empty' do
    it 'costs nothing' do
      expect(subject.total_cost).to eq(0)
    end
  end

  context 'with items' do
    let(:no_discounts) { double :Discounts, discount_percentage: 1.0 }
    subject { Order.new(material, no_discounts) }

    it 'returns the total cost of all items' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, express_delivery

      expect(subject.total_cost).to eq(30)
    end

    context 'with discount' do
      context 'total amount' do
        let(:discounts) { double :Discounts, discount_percentage: 0.9 }
        subject { Order.new(material, discounts) }

        it 'adds discount when total is greater than 30' do
          broadcaster_1 = Broadcaster.new(1, 'Viacom')
          broadcaster_2 = Broadcaster.new(2, 'Disney')
          broadcaster_3 = Broadcaster.new(3, 'Discovery')
          broadcaster_4 = Broadcaster.new(4, 'ITV')

          subject.add broadcaster_1, standard_delivery
          subject.add broadcaster_2, standard_delivery
          subject.add broadcaster_3, standard_delivery
          subject.add broadcaster_4, standard_delivery

          expect(subject.total_cost).to eq(36)
        end
      end

      context 'number of express deliveries' do
        it 'adds discount the cost of express delivery when 2 or more' do
          broadcaster_1 = Broadcaster.new(1, 'Viacom')
          broadcaster_2 = Broadcaster.new(2, 'Disney')

          subject.add broadcaster_1, express_delivery
          subject.add broadcaster_2, express_delivery

          expect(subject.total_cost).to eq(30)
        end
      end

      context 'both discounts applied' do
        let(:discounts) { double :Discounts, discount_percentage: 0.9 }
        subject { Order.new(material, discounts) }

        it 'adds discount the cost of express delivery when 2 or more and total discount applied' do
          broadcaster_1 = Broadcaster.new(1, 'Viacom')
          broadcaster_2 = Broadcaster.new(2, 'Disney')

          subject.add broadcaster_1, express_delivery
          subject.add broadcaster_2, express_delivery
          subject.add broadcaster_2, standard_delivery

          expect(subject.total_cost).to eq(36)
        end
      end
    end
  end
end
