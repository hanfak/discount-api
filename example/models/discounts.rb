class Discounts
  attr_reader :discount_total_amount, :discount_total_minimum, :total_express_minimum, :express_discount

  def initialize(discount_total_amount:, discount_total_minimum:, total_express_minimum:, express_discount:)
    @discount_total_amount = discount_total_amount
    @discount_total_minimum = discount_total_minimum
    @total_express_minimum = total_express_minimum
    @express_discount = express_discount
  end

  def total_cost_percentage(total)
    total > discount_total_minimum ? (1.0 - discount_total_amount) : 1.0
  end

  def express_delivery_percentage(delivery_type, total_deliveries)
    delivery_type == :express && total_deliveries > total_express_minimum ? express_discount : 1.0
  end
end
