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
        if !total_inventory.key?(item)
          total_inventory[item]
          @vendors.each do |vendor|
            total_inventory[item][:quantity]+= vendor.check_stock(item)
          end
        else
        end
        total_inventory[item][:vendors] = vendors_that_sell(item)
      end
    end
    total_inventory
  end
end
