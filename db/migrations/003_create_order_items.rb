Sequel.migration do
  change do
    create_table(:order_items) do
      primary_key :id
      DateTime :created_at
      DateTime :updated_at
      Integer :product_id
      Integer :order_id
      Float :msrp_multiple
      Float :sale_price
    end
  end
end