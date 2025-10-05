# Sequel Migration Rake Tasks
# lib/tasks/sequel.rake

require 'sequel'

namespace :sequel do
  desc "Run Sequel migrations"
  task :migrate => :environment do
    require_relative '../../config/database_sequel'
    require 'sequel/extensions/migration'
    
    migration_dir = Rails.root.join('db', 'sequel_migrations')
    
    if Dir.exist?(migration_dir)
      puts "Running Sequel migrations from #{migration_dir}"
      Sequel::Migrator.run(DB, migration_dir)
      puts "Sequel migrations completed!"
    else
      puts "No migration directory found at #{migration_dir}"
    end
  end
  
  desc "Rollback Sequel migrations"
  task :rollback => :environment do
    require_relative '../../config/database_sequel'
    require 'sequel/extensions/migration'
    
    migration_dir = Rails.root.join('db', 'sequel_migrations')
    version = ENV['VERSION']&.to_i
    
    if Dir.exist?(migration_dir)
      puts "Rolling back Sequel migrations..."
      if version
        Sequel::Migrator.run(DB, migration_dir, target: version)
        puts "Rolled back to version #{version}"
      else
        puts "Please specify VERSION=<number> to rollback to"
      end
    else
      puts "No migration directory found at #{migration_dir}"
    end
  end
  
  desc "Show current Sequel migration version"
  task :version => :environment do
    require_relative '../../config/database_sequel'
    
    migration_dir = Rails.root.join('db', 'sequel_migrations')
    
    if Dir.exist?(migration_dir)
      current_version = DB[:schema_migrations].max(:filename) rescue "No migrations run yet"
      puts "Current Sequel migration version: #{current_version}"
    else
      puts "No migration directory found"
    end
  end
  
  desc "Create a new Sequel migration"
  task :create_migration, [:name] => :environment do |t, args|
    name = args[:name] || ENV['NAME']
    
    if name.nil?
      puts "Please provide a migration name: rake sequel:create_migration[migration_name]"
      exit 1
    end
    
    migration_dir = Rails.root.join('db', 'sequel_migrations')
    FileUtils.mkdir_p(migration_dir)
    
    # 次の番号を取得
    existing_files = Dir.glob(File.join(migration_dir, "*.rb"))
    next_number = existing_files.length + 1
    
    filename = "%03d_%s.rb" % [next_number, name.downcase.gsub(/[^a-z0-9]/, '_')]
    filepath = File.join(migration_dir, filename)
    
    template = <<~RUBY
      # Sequel Migration: #{name}
      # #{filepath}
      
      Sequel.migration do
        up do
          # Add your migration code here
        end
        
        down do
          # Add your rollback code here
        end
      end
    RUBY
    
    File.write(filepath, template)
    puts "Created migration: #{filepath}"
  end
end
