module PelitaExample
  Container.finalize(:persistence) do |container|
    init do
      # Setup connection string
      db_config = Application.
        fetch_db_config("#{Application.config.root}/config/database.yml")[Application.config.env]
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
