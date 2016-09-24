require "spec_helper"

feature 'Feature Tests' do
  feature 'Example 1' do
    let(:standard_delivery) { Delivery.new(:standard, 10) }
    let(:express_delivery) { Delivery.new(:express, 20) }
    let(:broadcaster_1) {Broadcaster.new(1, 'Viacom')}
    let(:broadcaster_2) {Broadcaster.new(2, 'Disney')}
    let(:broadcaster_3) {Broadcaster.new(3, 'Discovery')}
    let(:broadcaster_4) {Broadcaster.new(4, 'Horse and Country')}
    let(:material) { Material.new 'WNP/SWCL001/010' }
    let(:discounts) { Discounts.new(discount_total_amount: 0.1,
                                    discount_total_minimum: 30,
                                    total_express_minimum: 1,
                                    express_discount: 0.75) }
    let(:order) { Order.new(material, discounts) }

    scenario 'applies correct discount and total is 45.00' do
      order.add broadcaster_1, standard_delivery
      order.add broadcaster_2, standard_delivery
      order.add broadcaster_3, standard_delivery
      order.add broadcaster_4, express_delivery

      expect(order.total_cost).to eq(45.00)
    end
  end

  feature 'Example 2' do
    let(:standard_delivery) { Delivery.new(:standard, 10) }
    let(:express_delivery) { Delivery.new(:express, 20) }
    let(:broadcaster_1) {Broadcaster.new(1, 'Viacom')}
    let(:broadcaster_2) {Broadcaster.new(2, 'Disney')}
    let(:broadcaster_3) {Broadcaster.new(3, 'Discovery')}
    let(:broadcaster_4) {Broadcaster.new(4, 'Horse and Country')}
    let(:material) { Material.new 'ZDW/EOWW005/010' }
    let(:order) { Order.new material }

    scenario 'applies correct discount and total is 40.50' do
      order.add broadcaster_1, express_delivery
      order.add broadcaster_2, express_delivery
      order.add broadcaster_3, express_delivery

      expect(order.total_cost).to eq(40.50)
    end
  end
end
