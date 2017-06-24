module RopExample
  Container.finalize(:persistence) do |container|
    init do
      adapter = ::ROM.container(:sql, 'sqlite::memory') do |conf|
        conf.default.create_table(:blog_posts) do
          primary_key :id
          column :title, String, null: false
          column :body, String
          column :author, String
        end
      end
      container.register(:adapter, adapter)

      %w(
        BlogPostRepo
      ).each do |repo|
        container.register(
          repo.to_snake_case.to_sym,
          RailwayEng::Persistence::Repository.const_get(repo).new(adapter)
        )
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