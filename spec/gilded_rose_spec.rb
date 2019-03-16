require 'gilded_rose'

describe GildedRose do
  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "decreases the quality value at the end of each day " do
      items = [Item.new("foo", 20, 50)]
      expect{ GildedRose.new(items).update_quality() }.to change{ items[0].quality }.by(-1)
    end

    it "decreases the sell_in value at the end of each day " do
      items = [Item.new("foo", 20, 50)]
      expect{ GildedRose.new(items).update_quality() }.to change{ items[0].sell_in }.by(-1)
    end

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
