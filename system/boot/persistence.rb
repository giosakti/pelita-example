module RopExample
  Container.finalize(:persistence) do |container|
    init do
      # Load db configuration
      db_config = File.read("#{Application.config.root}/config/database.yml")
      db_config = ERB.new(db_config).result
      db_config = YAML.load(db_config)

      # Setup connection string
      db_config = db_config[Application.config.env]
      conn_string = db_config['adapter']

      unless db_config['host'].blank?
        host_string = db_config['host']
        host_string = "#{host_string}:#{db_config['port']}" unless db_config['port'].blank?

        unless db_config['username'].blank?
          user_string = db_config['username']
          user_string = "#{user_string}:#{db_config['password']}" unless db_config['password'].blank?
          host_string = "#{user_string}@#{host_string}"
        end

        conn_string = "#{conn_string}://#{host_string}"
        conn_string = "#{conn_string}/#{db_config['database']}" unless db_config['database'].blank?
      end

      # Initiate db connection
      db = ::ROM.container(:sql, conn_string) do |conf|
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
