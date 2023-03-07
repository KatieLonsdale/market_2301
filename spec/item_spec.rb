require './lib/item'
require './lib/vendor'
require 'rspec'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@item2).to be_a Item
      expect(@item2.name).to eq('Tomato')
      expect(@item2.price).to eq 0.5
    end
  end

  describe '#format_price' do
    it 'turns string price into float' do
      expect(@item1.format_price('$0.75')).to eq 0.75
      expect(@item1.format_price('0.75')).to eq 0.75
      expect(@item1.format_price('$1')).to eq 1.00
    end
  end
end