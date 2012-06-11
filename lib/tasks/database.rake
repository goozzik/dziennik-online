namespace :db do

  desc 'bootstrap database'
  task :bootstrap do
    Rake::Task['db:drop:all'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
  end

end
