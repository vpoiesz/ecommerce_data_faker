Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      DateTime :created_at
      DateTime :updated_at
      String :name
    end
    
    now = Time.now.utc
    u = {name: "Wile E Coyote", created_at: now, updated_at: now}
    from(:users).insert(u)
  end
  
  down do
    drop_table(:users)
  end
end