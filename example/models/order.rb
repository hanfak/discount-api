class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :discounts, :items

  def initialize(material, discounts =
                Discounts.new(discount_total_amount: 0.1,
                              discount_total_minimum: 30))
    self.material = material
    self.discounts = discounts
    self.items = []
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def total_cost
    sub_total * discounts.discount_percentage(sub_total)
  end

  def output
    [].tap do |result|
      result << "Order for #{material.identifier}:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end

      result << output_separator
      result << "Total: $#{total_cost}"
    end.join("\n")
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end

  def sub_total
    items.inject(0) do |memo, (_, delivery)|
      memo += delivery.name == :express && total_express_deliveries > 1 ? 15 : delivery.price
    end
  end

  def total_express_deliveries
    items.select { |(_, delivery)| delivery.name == :express}.size
  end
end
