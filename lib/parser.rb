class Parser

  attr_reader :target, :item_hash

  def initialize(file)

    @item_hash = {}

    File.open(file).each_with_index do |line, i|
      if i == 0
      @target = Permutationator.currency_to_number(line)
      else
        menu_item = line.split(',')
        @price = Permutationator.currency_to_number(menu_item[1])
        @item_hash[@price] = menu_item[0]
      end
    end
  end
end
