class GildedRose
  SULFURAS = 80
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != aged_brie? and item.name != backstage_pass?
        if item.quality > MIN_QUALITY
          if item.name != sulfuras?
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < MAX_QUALITY
          item.quality = item.quality + 1
          if item.name == backstage_pass?
            if item.sell_in < 11
              if item.quality < MAX_QUALITY
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < MAX_QUALITY
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != sulfuras?
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != aged_brie?
          if item.name != backstage_pass?
            if item.quality > MIN_QUALITY
              if item.name != sulfuras?
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < MAX_QUALITY
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

    def decrease_backstage_pass(item)
        if item.sell_in <= 0
          item.quality = MIN_QUALITY
        elsif item.sell_in < 11 && item.quality < MAX_QUALITY
          item.quality = item.quality + 2
        elsif item.sell_in < 6 && item.quality < MAX_QUALITY
          item.quality = item.quality + 3
        else
          item.quality = item.quality + 1
        end
    end

    def increase_aged_brie(item)

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

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
