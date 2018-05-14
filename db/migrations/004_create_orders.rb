Sequel.migration do
  change do
    create_table(:orders) do
      primary_key :id
      DateTime :created_at
      DateTime :updated_at
      Integer :user_id
      Float :subtotal
      Float :tax_multiple
      Float :amount
    end
  end
end