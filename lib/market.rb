class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map{|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.keys.include?(item)
    end
  end
  
  def sorted_item_list
    items = @vendors.map do |vendor| 
      vendor.inventory.keys.map{|item| item.name}
    end
    items.flatten.uniq.sort
  end

  def total_inventory
    total_inventory = Hash.new {|h,k| h[k] = {quantity: 0, vendors: []}}
    @vendors.map do |vendor|
      vendor.inventory.each do |item, quantity|
        total_inventory[item] if !total_inventory.key?(item)
        total_inventory[item][:quantity]+= vendor.check_stock(item)
        total_inventory[item][:vendors] = vendors_that_sell(item)
      end
    end
    total_inventory
  end

  def overstocked_items
    overstocked = []
    total_inventory.map do |item, item_info|
      if (item_info[:quantity] > 50) && (item_info[:vendors].count > 1)
        overstocked << item
      end
    end
    overstocked
  end
end
