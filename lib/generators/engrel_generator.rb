require 'rails/generators/migration'

# Very simple--we're doing a straight copy of the migration.
class EngrelGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @_acts_as_engrelable_source_root ||= File.expand_path("../templates", __FILE__)
  end

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_model_file
    template "engrel.rb", "app/models/engrel.rb"
    migration_template "create_engrel_tables.rb", "db/migrate/create_engrel_tables.rb"
  end
end
