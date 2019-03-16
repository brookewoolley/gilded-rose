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
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(49)
    end

    it 'decreases the quality value by 2 if the sell by date has passed' do
      items = [Item.new("foo", 0, 50)]
      expect{ GildedRose.new(items).update_quality() }.to change{ items[0].quality }.by(-2)
    end

    it "decreases the sell_in value at the end of each day " do
      items = [Item.new("foo", 20, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(19)
    end

    it 'does not update the quality of Sulfuras' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(80)
    end

    it 'does not update the sell_in value of Sulfuras' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(0)
    end

    it 'increases the quality of aged brie by 1' do
      items = [Item.new("Aged Brie", 2, 10)]
      expect{ GildedRose.new(items).update_quality() }.to change{ items[0].quality }.by(+1)
    end

    it 'increases the quality of backstage passes by 2 when sell_in date is 10 or less' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 10)]
      expect{ GildedRose.new(items).update_quality() }.to change{ items[0].quality }.by(+2)
    end

    it 'increases the quality of backstage passes by 3 when sell_in date is 5 or less' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 10)]
      expect{ GildedRose.new(items).update_quality() }.to change{ items[0].quality }.by(+3)
    end

    it 'drops quality to 0 for backstage passes after the sell_in date has passed' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end

    it 'decreases the quality value for conjured items by 2 at the end of each day' do
      items = [Item.new("Conjured", 20, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(38)
    end
  end
end
