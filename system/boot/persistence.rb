module RopExample
  Container.finalize(:persistence) do |container|
    init do
      # Setup primary database
      db = ::ROM.container(:sql, 'sqlite::memory') do |conf|
        conf.default.create_table(:blog_posts) do
          primary_key :id
          column :title, String, null: false
          column :body, String
          column :author, String
        end
      end
      container.register(:db, db)

      # Load all repositories
      [
        RailwayEng::Persistence::Repository::BlogPostRepo,
      ].each do |repo|
        container.register(repo.to_s.split('::').last.to_snake_case.to_sym, repo.new(db))
      end
    end

    start do
      # NOP
    end

    stop do
      # NOP
    end
  end
end
