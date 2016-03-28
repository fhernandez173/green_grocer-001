require 'pry'

def consolidate_cart(cart:[])
  # cart = [
  #   {"TEMPEH"=>{
  #     :price=>3.0,
  #     :clearance=>true}},
  #   {"PEANUTBUTTER"=>{
  #     :price=>3.0,
  #     :clearance=>true}},
  #   {"ALMONDS"=>{
  #     :price=>9.0,
  #     :clearance=>false}
  #   }
  # ]
  # store the number of times an item appears
  food_hash = {}
  cart.each do |item|
    # binding.pry
    item.each do |food_key, food_values|
      # food_values.each do |data_key, data_value|
      # food_hash doesnt have item in it, add the count and equal to 1
      # I could use unless here or use ! to
      if !food_hash[food_key]
        # binding.pry
        food_hash[food_key] = food_values
        food_hash[food_key][:count] = 1
      # food_hash has it, add one to :count
      else
        # binding.pry
        food_hash[food_key][:count] += 1
      end
      # end
    end
  end
  return food_hash
    # binding.pry
end

def apply_coupons(cart:[], coupons:[])
  # binding.pry
  items_in_the_cart = {
    "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
    "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
  }
  item_in_the_coupon = [{:item => "AVOCADO", :num => 2, :cost => 5.0}]
  the_expected_outcome = {
    "AVOCADO" => {:price => 3.0, :clearance => true, :count => 1},
    "KALE"    => {:price => 3.0, :clearance => false, :count => 1},
    "AVOCADO W/COUPON" => {:price => 5.0, :clearance => true, :count => 1},
  }
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  # binding.pry
  return cart
end

def apply_clearance(cart:[])
  cart.collect do |item, item_description|
    if item_description[:clearance] == true
      # 20% of something, multiply by 20%, get a number, then subtract it from original
      twenty_percent = item_description[:price] * 0.2
      item_description[:price] -= twenty_percent
    end
    # binding.pry
  end
  cart
end

def checkout(cart: [], coupons: [])
  # binding.pry
  # cart_1 = {}
  cart_1 = consolidate_cart(cart: cart)
  # cart_1["BEETS"][:price]
  cart_2 = apply_coupons(cart: cart_1, coupons: coupons)
  cart_3 = apply_clearance(cart: cart_2)
  # coupon_1 = coupons
  total = 0
#   cart_1.each do |item_array|
#     consolidate_cart(cart: [item_array])
#     apply_coupons(cart: item_array, coupons: coupons)
#     # binding.pry
#     apply_clearance(cart: item_array)
#   # binding.pry
# end
  # cart_1

  cart_3.each do |name, properties|
     total += properties[:price] * properties[:count]
   end
   total = total * 0.9 if total > 100
   total
end













##
