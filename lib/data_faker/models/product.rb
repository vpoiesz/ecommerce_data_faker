module DataFaker
  class Product < Sequel::Model
    one_to_many :order_items
    
  end
end