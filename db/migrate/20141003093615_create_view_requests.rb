class CreateViewRequests < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE VIEW categories_online_counts AS SELECT count(a.id) as requests, a.category_id from game_requests as a inner join 
    check_onlines as b on (a.user_id = b.user_id and (DATE_PART('minute', NOW() at time zone 'utc' - b.time)<=15) and DATE_PART('hour', NOW() at time zone 'utc' - b.time)<1) group by a.category_id
    SQL
  end
  def self.down
    execute <<-SQL
      DROP VIEW categories_online_counts
    SQL
  end
end

