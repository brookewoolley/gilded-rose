require 'item'

class GildedRose
  SULFURAS = 80
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == sulfuras?
        maintain_sulfuras(item)
      elsif item.name == backstage_pass?
        update_backstage_pass(item)
      elsif item.name == aged_brie?
        increase_aged_brie(item)
      else
        decrease_standard_item(item)
      end
    end
  end

  def update_backstage_pass(item)
    if item.sell_in == 0
      item.quality -= item.quality
    elsif item.sell_in < 6 && item.quality < MAX_QUALITY
      item.quality = item.quality + 3
    elsif item.sell_in < 11 && item.quality < MAX_QUALITY
      item.quality = item.quality + 2
    else
      item.quality += item.quality
    end
  end

  def maintain_sulfuras(item)
    item.quality = SULFURAS
    item.sell_in = item.sell_in
  end

  def decrease_standard_item(item)
    if item.sell_in > 0
      item.quality = item.quality - 1
      item.sell_in = item.sell_in - 1
    else
      item.quality = item.quality - 2
      item.sell_in = item.sell_in - 1
    end
  end

  def increase_aged_brie(item)
    item.quality = item.quality + 1
    item.sell_in = item.sell_in - 1
  end

  def backstage_pass?
    "Backstage passes to a TAFKAL80ETC concert"
  end

  def aged_brie?
    "Aged Brie"
  end

  def sulfuras?
    "Sulfuras, Hand of Ragnaros"
  end
end
