class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items

  def initialize(material, discounts =
                Discounts.new(discount_total_amount: 0.1,
                              discount_total_minimum: 30,
                              total_express_minimum: 1,
                              express_discount: 0.75 ))
    self.material = material
    self.items = []
    @discounts = discounts

  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def total_cost
    total = sub_total
    total * discounts.total_cost_percentage(total)
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
  attr_reader :discounts

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end

  def sub_total
    items.inject(0) do |memo, (_, delivery)|
      memo += delivery.price * discounts.express_delivery_percentage(delivery.name, total_express_deliveries)
    end
  end

  def total_express_deliveries
    items.select { |(_, delivery)| delivery.name == :express}.size
  end
end
