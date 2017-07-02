module PelitaExample
  Container.finalize(:persistence) do |container|
    init do
      # Load db configuration
      db_config = File.read("#{Application.config.root}/config/database.yml")
      db_config = ERB.new(db_config).result
      db_config = YAML.load(db_config)

      # Setup connection string
      db_config = db_config[Application.config.env]
      conn_string = Application.generate_connection_string(db_config)

      # Initiate db connection
      db = ::Pelita::Persistence.container(:sql, conn_string) do |conf|
        # NOP
      end

      # Register db on the container
      container.register(:db, db)
    end

    start do
      # NOP
    end

    stop do
      # NOP
    end
  end
end
