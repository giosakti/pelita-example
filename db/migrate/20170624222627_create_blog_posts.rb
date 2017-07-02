Pelita::SQL.migration do
  change do
    create_table(:blog_posts) do
      primary_key :id
      String :username, null: false
      String :body
      String :author
    end
  end
end
