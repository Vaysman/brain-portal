class CreateViewCategoryRequests < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE VIEW categories_online_counts AS SELECT count(a.id) as requests, a.category_id from game_requests as a inner join 
    check_onlines as b on (a.user_id = b.user_id and DATE_PART('minute', NOW() - b.time)<=15) group by a.category_id
    SQL
  end
  def self.down
    execute <<-SQL
      DROP VIEW categories_online_counts
    SQL
  end
end

