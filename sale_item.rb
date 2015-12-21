require 'JSON'

class SaleItem
  attr_reader :item_number, :item_description, :number_in_stock
  def initialize(item_number, item_description, number_in_stock)
    @item_number = item_number
    @item_description = item_description
    @number_in_stock = number_in_stock
  end

  def to_json(*generator)
    {
      'item_number' => @item_number,
      'item_description' => @item_description,
      'number_in_stock' => @number_in_stock
    }.to_json(*generator)
  end

end

class SaleItemDao

  def initialize
    # Really should do DB connection, etc, but lets just stub it out for now
    item1 = SaleItem.new(1, 'Floor Cleaner', 12)
    item2 = SaleItem.new(2, 'Carpet', 5)
    @sale_items = [item1, item2]
  end

  def get_all
    return @sale_items
  end

  def get(id)
    @sale_items.each do |item|
      return item if item.item_number == id
    end
    return nil
  end

  def add(item)
    return nil unless (item.is_a? SaleItem)
    @sale_items.push item
  end
end