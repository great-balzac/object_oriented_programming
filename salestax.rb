class Cart

  def initialize
    @contents_of_cart = []
  end

  def name(name_of_cart)
  	@name_of_cart = name_of_cart
  end

  def add_item(incoming_item)
    @incoming_item = incoming_item
    @contents_of_cart << @incoming_item
  end

  def remove_item(returning_item)
    @returning_item = returning_item
    @contents_of_cart.delete(@returning_item)
  end

  def list_contents
	puts "\nContents of: #{@name_of_cart}"
	@contents_of_cart.each {
		|item|
		puts "#{item.quantity_of_item} x #{item.name_of_item} #{(item.item_price + item.item_tax).round(2)}."
		puts "is imported? = #{item.is_imported}, is tax exempt? = #{item.tax_exempt}."
	}
	draw_separator
  end

  def cart_tax
	@cart_after_tax = 0.0
	@taxes_total = 0.0
	
	# Tallies @taxes_total
	@contents_of_cart.each {
	  |item|
	    @taxes_total += (item.item_tax + item.import_tax)
		}
	
	# Tallies @cart_after_tax
	@contents_of_cart.each {
	  |item|
	    @cart_after_tax += (item.item_price + item.item_tax + item.import_tax)
		}
	
	# end of tax calculation
    
	# Display total sales tax and total
	draw_separator
	puts "\nSales Taxes: #{@taxes_total.round(2)}"
	puts "\nTotal: #{@cart_after_tax.round(2)}"
	
	#puts "\nSales Taxes: #{self.round_up_5cents(@taxes_total)}"
	#puts "\nTotal: #{self.round_up_5cents(@cart_after_tax)}"
	
  end # cart_tax
  
  def checkout
	puts"\n#{@name_of_cart}"
	draw_separator
  	#@cart_checkout_total = 0
  	
	self.list_contents
	self.cart_tax
	draw_separator
	
  end

end # Cart class

class Item
    attr_accessor :name_of_item, :item_price, :is_imported,
	  :tax_exempt, :quantity_of_item, :item_tax, :import_tax


  def name(name_of_item)
  	@name_of_item = name_of_item
  end # name

  def price(item_price)
    @item_price = item_price
  end

  def imported(import)
  	@is_imported = import
	@import_tax = 0.0
	# Detects if imported
  	if @is_imported == true
      @import_tax += (@item_price * 0.05)
	  @import_tax
    else
    end
  end

  def exempt(tax_exempt)
	# True = item is tax exempt
  	@tax_exempt = tax_exempt
  end

  def quantity(quantity_of_item)
	@quantity_of_item = quantity_of_item
  end
  
  def tax
  	@item_tax = 0

  	# Detects if tax exempt
  	if @tax_exempt == false
      @item_tax += (@item_price * 0.1)
	  @item_tax
  	else
  	end

  end # Item tax
  
end # Item class

  def draw_separator
    15.times { print "_"}
  end

  def round_up_5cents(num_to_round)
   	# Round number up to nearest 0.05
    num_to_round = ((num_to_round*20.0).ceil) / 20.0
  end # round_up_5cents
  
# HOW TO USE ITEM CLASS METHODS
# =============================
# book = Item.new
# book.name("Something")
# book.price(12.99)
# book.imported(false)
# book.exempt(true)
# book.quantity(1)
# book.tax

# HOW TO USE CART CLASS METHODS
# =============================
# users_cart = Cart.new
# users_cart.name("My Cart")
# users_cart.add_item(book)
# users_cart.remove_item(book)
# users_cart.list_contents
# users_cart.checkout

# INPUT 1
# User selects items
book = Item.new
book.name("Book")
book.price(12.49)
book.imported(false)
book.exempt(true)
book.quantity(1)
book.tax

music_cd = Item.new
music_cd.name("Music CD")
music_cd.price(14.99)
music_cd.imported(false)
music_cd.exempt(false)
music_cd.quantity(1)
music_cd.tax

chocolate_bar = Item.new
chocolate_bar.name("Chocolate bar")
chocolate_bar.price(0.85)
chocolate_bar.imported(false)
chocolate_bar.exempt(true)
chocolate_bar.quantity(1)
chocolate_bar.tax

Input_1 = Cart.new
Input_1.name("Input 1")
Input_1.add_item(book)
Input_1.add_item(music_cd)
Input_1.add_item(chocolate_bar)
Input_1.checkout

draw_separator

# INPUT 2
# User selects items
box_of_chocolates = Item.new
box_of_chocolates.name("Imported box of chocolates")
box_of_chocolates.price(10.00)
box_of_chocolates.imported(true)
box_of_chocolates.exempt(true)
box_of_chocolates.quantity(1)
box_of_chocolates.tax

bottle_of_perfume = Item.new
bottle_of_perfume.name("Imported bottle of perfume")
bottle_of_perfume.price(47.50)
bottle_of_perfume.imported(true)
bottle_of_perfume.exempt(false)
bottle_of_perfume.quantity(1)
bottle_of_perfume.tax

Input_2 = Cart.new
Input_2.name("Input 2")
Input_2.add_item(box_of_chocolates)
Input_2.add_item(bottle_of_perfume)
Input_2.checkout

# INPUT 3
# User selects items
bottle_of_perfume2 = Item.new
bottle_of_perfume2.name("Imported bottle of perfume")
bottle_of_perfume2.price(27.99)
bottle_of_perfume2.imported(true)
bottle_of_perfume2.exempt(false)
bottle_of_perfume2.quantity(1)
bottle_of_perfume2.tax

bottle_of_perfume3 = Item.new
bottle_of_perfume3.name("Bottle of perfume")
bottle_of_perfume3.price(18.99)
bottle_of_perfume3.imported(false)
bottle_of_perfume3.exempt(false)
bottle_of_perfume3.quantity(1)
bottle_of_perfume3.tax

headache_pills = Item.new
headache_pills.name("Packet of headache pills")
headache_pills.price(9.75)
headache_pills.imported(false)
headache_pills.exempt(true)
headache_pills.quantity(1)
headache_pills.tax

box_of_chocolates2 = Item.new
box_of_chocolates2.name("Box of imported chocolates")
box_of_chocolates2.price(11.25)
box_of_chocolates2.imported(true)
box_of_chocolates2.exempt(false)
box_of_chocolates2.quantity(1)
box_of_chocolates2.tax

Input_3 = Cart.new
Input_3.name("Input 3")
Input_3.add_item(bottle_of_perfume2)
Input_3.add_item(bottle_of_perfume3)
Input_3.add_item(headache_pills)
Input_3.add_item(box_of_chocolates2)
Input_3.checkout
