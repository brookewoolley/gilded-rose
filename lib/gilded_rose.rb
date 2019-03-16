require 'item'

class GildedRose
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  CONJURED = "Conjured"

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == SULFURAS
        maintain_item(item)
      elsif item.name == BACKSTAGE_PASS
        update_backstage_pass(item)
      elsif item.name == AGED_BRIE
        increase_quality_by_one(item)
        decrease_sellin_by_one(item)
      elsif item.name == CONJURED
        decrease_quality_by_two(item)
        decrease_sellin_by_one(item)
      else
        decrease_standard_item(item)
      end
    end
  end

  private

  def update_backstage_pass(item)
    if item.sell_in == 0
      item.quality -= item.quality
    elsif item.sell_in < 6 && item.quality < MAX_QUALITY
      item.quality = item.quality + 3
    elsif item.sell_in < 11 && item.quality < MAX_QUALITY
      item.quality = item.quality + 2
    else
      increase_quality_by_one(item)
    end
  end

  def maintain_item(item)
    item.quality = item.quality
    item.sell_in = item.sell_in
  end

  def decrease_standard_item(item)
    if item.sell_in > 0
      item.quality = item.quality - 1
      decrease_sellin_by_one(item)
    else
      decrease_quality_by_two(item)
      decrease_sellin_by_one(item)
    end
  end

  def increase_quality_by_one(item)
    item.quality = item.quality + 1
  end

  def decrease_sellin_by_one(item)
    item.sell_in = item.sell_in - 1
  end

  def decrease_quality_by_two(item)
    item.quality = item.quality - 2
  end

end
