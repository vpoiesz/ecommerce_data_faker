module DataFaker
  class User < Sequel::Model
    one_to_many :orders
    
    def self.get_for_new_order
      user = select(:id).all.sample
      user = User.create(name: Faker::Name.name) if user.nil? || DFRandom.rand(5) == 0  
      return user
    end
    
  end
end