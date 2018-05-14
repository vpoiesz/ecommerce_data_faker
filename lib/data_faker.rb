lib_dir  = File.dirname(__FILE__)
root_dir = File.join(lib_dir, '..')
APP_ROOT = File.expand_path(root_dir)

# Require bundle
require 'rubygems'
require 'bundler'
Bundler.require(:default)

# Require from stdlib
require 'ostruct'
require 'yaml'
require 'logger'

module DataFaker
  
  Config = OpenStruct.new(YAML.load_file(File.join(APP_ROOT, 'config.yml')))
  DB     = Sequel.connect(adapter:  'mysql2',
                          user:     Config.db_user,
                          password: Config.db_password,
                          host:     Config.db_host,
                          port:     Config.db_port,
                          database: Config.db_database#,
                          #loggers:  [Logger.new(STDOUT)]
                          )
  
  Sequel.default_timezone = :utc                        
  Sequel::Model.plugin :timestamps, update_on_create: true
  Sequel::Model.plugin :update_or_create
  
  Sequel.extension :migration
  @@migrations_dir = File.join(APP_ROOT, 'db', 'migrations')
  
  def self.require_lib
    path = File.join(APP_ROOT, 'lib', 'data_faker', '**', '*.rb')  
    Dir.glob(path).each { |f| require  f }
  end
  
  def self.run!
    puts "Ecommerce Data Faker starting"
    run_migrations_to_latest unless Sequel::Migrator.is_current?(DB, @@migrations_dir)
    require_lib
    
    begin
      loop do
        order = Order.generate_fake
        puts "#{order.created_at} - Inserted order #{order.id}"
        sleep(Config.wait_time_seconds)
      end
    rescue SignalException
      puts "\nQuitting"
      exit
    end
  end
  
  def self.reset!
    puts "Truncating all data"
    run_migrations_to_version(0)
    exit
  end
  
  def self.run_migrations_to_latest
    puts "Running new migrations"
    run_migrations_to_version(:latest)
  end
  
  def self.run_migrations_to_version(target=:latest)
    target = nil if target == :latest
    Sequel::Migrator.run(DB, @@migrations_dir, target: target)
  end
  
end