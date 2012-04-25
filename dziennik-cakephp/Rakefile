require 'rake'

DB_NAME="db_name"
DB_USER="db_user"
DB_ENCONDING="UNICODE"
DB_BOOTSTRAP="db/bootstrap.sql"
DB_MIGRATION="app/sql"

POSTGRES_HOST="postgre_host"
ENV["PGPASSWORD"] = "xxxxxxxxxxxxxxxx"

namespace :db do

  desc 'Bootstrap clean database'
  task :bootstrap => [ :drop, :create ] do
    system("cat #{DB_BOOTSTRAP} | psql -h #{POSTGRES_HOST} -U #{DB_USER} #{DB_NAME}")
  end

  desc 'Drop database'
  task :drop do
    system("dropdb -h #{POSTGRES_HOST} -U #{DB_USER} #{DB_NAME}")
  end

  desc 'Create database'
  task :create do
    system("createdb --template template0 -h #{POSTGRES_HOST} -E #{DB_ENCONDING} -U #{DB_USER} #{DB_NAME}")
  end

  task :bootstrap_refresh_raw do
    system("pg_dump -h #{POSTGRES_HOST} -U #{DB_USER} #{DB_NAME} > #{DB_BOOTSTRAP}")
  end

  desc 'Refresh bootstrap to match current migrations'
  task :bootstrap_refresh => [ :migrate, :bootstrap_refresh_raw ] do
  end

  desc 'Create new database fully migrated'
  task :migrate => [ :drop, :create, :create_lang, :migrate_raw ] do
    puts "migrate finished"
  end

  task :create_lang do
    system("createlang -h #{POSTGRES_HOST} -U #{DB_USER} plpgsql pg59_3")
  end

  task :migrate_raw do
    system("cat #{DB_MIGRATION}/gallery/*.sql | psql -h #{POSTGRES_HOST} -U #{DB_USER} #{DB_NAME}")
    system("cat #{DB_MIGRATION}/00[1-9].sql | psql -h #{POSTGRES_HOST} -U #{DB_USER} #{DB_NAME}")
    system("cat #{DB_MIGRATION}/0[1-9][0-9]*.sql | psql -h #{POSTGRES_HOST} -U #{DB_USER} #{DB_NAME}")
  end

  desc "SQL console on development"
  task :console do
    system("psql -h #{POSTGRES_HOST} -U #{DB_USER} #{DB_NAME}")
  end

  desc "SQL console on production"
  task :console_production do
    system("psql -h production_console prod_user prod_db")
  end
end

namespace :test do

  desc 'Run changed scenarios'
  task :changed do
    system('cucumber `git st | grep "\.feature" | cut -b3- | tr "\n" " "`')
  end

  desc 'Run production (live) testing'
  task :production do
    system('materials/test_live_system.sh')
  end

  desc 'Run changed scenarios on production (live)'
  task :production_changed do
    system('materials/test_live_system.sh `git st | grep "\.feature" | cut -b3- | tr "\n" " "`')
  end

end
