module DataFaker
  class OrderItem < Sequel::Model
    many_to_one :order
    many_to_one :product
    
    def self.generate_for_order(order)
      number_of_items = DFRandom.rand_from_one(6)
      all_products = Product.select(:id, :msrp).all
      chosen_products = number_of_items.times.map{ all_products.sample }
      chosen_products.each do |p|
        msrp_multiple = DFRandom.rand_msrp_multiple
        sale_price = (p.msrp * msrp_multiple).round(2)
        order.add_order_item(product_id: p.id, msrp_multiple: msrp_multiple, sale_price: sale_price)
      end
    end
    
  end
end