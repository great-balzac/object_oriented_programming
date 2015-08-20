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
	puts "Contents of: #{@name_of_cart}"
	@contents_of_cart.each {
		|item|
		puts "#{item.quantity_of_item} x #{item.name_of_item}"
	}
	draw_separator
  end

  def checkout
  	@cart_checkout_total = 0
  	@contents_of_cart.each {
  			|item|
  			@cart_checkout_total += (item.after_tax * item.quantity_of_item)
			
			puts "\n#{item.item_price} x #{item.quantity_of_item} #{item.name_of_item}"
  		}
	
	draw_separator
  	puts "\nTOTAL AFTER TAX: #{@cart_checkout_total}"
  end

end # Cart class

class Item
    attr_accessor :name_of_item, :item_price, :quantity_of_item, :after_tax


  def name(name_of_item)
  	@name_of_item = name_of_item
  end # name

  def price(item_price)
    @item_price = item_price
  end

  def imported(import_bool)
  	@import_bool = import_bool
  end

  def exempt(tax_bool)
  	@tax_bool = tax_bool
  end

  def quantity(quantity_of_item)
	@quantity_of_item = quantity_of_item
  end
	
  def tax

  	@after_tax = @item_price

  	# Detects if tax exempt
  	if @tax_bool == false
      @after_tax += (@item_price * 1.1)
  	else
  	end

  	# Detects if imported
  	if @import_bool == true
      @after_tax += (@item_price * 0.05)
    else
    end

    # Round number up to nearest 0.05
    @after_tax = ((@after_tax*20).ceil) / 20
  end

end # Item class

  def draw_separator
    15.times { print "_"}
  end

book = Item.new
book.name("Something")
book.price(12.99)
book.imported(false)
book.exempt(true)
book.quantity(1)
book.tax

users_cart = Cart.new
users_cart.name("My Cart")
users_cart.add_item(book)
users_cart.remove_item(book)
users_cart.list_contents
users_cart.checkout



# List.new(book, cd, cbar).calculate_list
#list = List.new
#list.add_item(book)
#list.add_item(cd)
#list.remove_item(book)
#list.print_receipt
