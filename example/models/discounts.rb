class Discounts
  attr_reader :discount_total_amount, :discount_total_minimum

  def initialize(discount_total_amount:, discount_total_minimum:)
    @discount_total_amount = discount_total_amount
    @discount_total_minimum = discount_total_minimum
  end

  def discount_percentage(total)
    total > discount_total_minimum ? (1.0 - discount_total_amount) : 1.0
  end
end
