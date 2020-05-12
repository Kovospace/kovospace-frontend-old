
namespace :cache_counter do

  desc 'Update all cache counters'
  task update: :environment do
    Skillset.connection
    Skillset.pluck(:id).map{|g_id| Skillset.reset_counters(g_id, :portfolios) }
  end



end
