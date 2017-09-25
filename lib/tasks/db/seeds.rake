Rake::Task['db:seed'].clear

namespace :db do
  task seed: :environment do
    Seedog.run
  end

  task 'seed:dry-run' => :environment do
    Seedog.dry_run
  end
end
