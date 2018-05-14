Sequel.migration do
  up do
    create_table(:products) do
      primary_key :id
      DateTime :created_at
      DateTime :updated_at
      String :name
      Float :msrp
    end
      
    # Inspired by http://looneytunes.wikia.com/wiki/List_of_ACME_Products
    products = [
      {name: "Rocket Powered Rollerskates", msrp: 299.99},
      {name: "Giant Kite Kit", msrp: 25.00},
      {name: "Bird Seed", msrp: 9.95},
      {name: "Nitroglycerin", msrp: 50.0},
      {name: "Detonator", msrp: 4.50},
      {name: "Glue", msrp: 2.75},
      {name: "Smoke Screen Bomb", msrp: 2.25},
      {name: "Giant Rubber Band", msrp: 12.00},
      {name: "Jet Propelled Pogo Stick", msrp: 110.10},
      {name: "Invisible Paint", msrp: 35.25},
    ]
    
    now = Time.now.utc
    insert_hashes = products.map{ |p| p.merge(created_at: now, updated_at: now) }
    from(:products).multi_insert(insert_hashes)
  end
  
  down do
    drop_table(:products)
  end
end