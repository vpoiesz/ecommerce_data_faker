module DataFaker
  class Order < Sequel::Model
    many_to_one :user
    one_to_many :order_items
    
    def self.generate_fake
      user = User.get_for_new_order
      order = user.add_order(tax_multiple: DFRandom.rand_tax_multiple)
      OrderItem.generate_for_order(order)
      order.finalize
      return order
    end
    
    def finalize
      subtotal = (order_items_dataset.sum(:sale_price)).round(2)
      amount = (subtotal * tax_multiple).round(2)
      self.update(subtotal: subtotal, amount: amount)
    end
    
  end
end