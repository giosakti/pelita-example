module RopExample
  Container.finalize(:persistence) do |container|
    init do
      # Setup primary database
      db = ::ROM.container(:sql, 'sqlite::memory') do |conf|
        # NOP
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
