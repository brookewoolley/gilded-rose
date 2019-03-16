require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it 'does not have a quality status of over 50' do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
    end

    # - "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
    it 'does not update the quality of Sulfuras' do
      item = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
      GildedRose.new(item).update_quality()
      expect(item[0].quality).to eq(0)
    end

    it 'does not update the sell_in value of Sulfuras' do
      item = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
      GildedRose.new(item).update_quality()
      expect(item[0].sell_in).to eq(0)
    end

  end

end

#
# - All items have a SellIn value which denotes the number of days we have to sell the item
# - All items have a Quality value which denotes how valuable the item is
# - At the end of each day our system lowers both values for every item
#
# Pretty simple, right? Well this is where it gets interesting:
#
# - Once the sell by date has passed, Quality degrades twice as fast
# - The Quality of an item is never negative
# - "Aged Brie" actually increases in Quality the older it gets
# - The Quality of an item is never more than 50
# - "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
# - "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
# Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
# Quality drops to 0 after the concert
