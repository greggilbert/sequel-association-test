require 'mysql2'
require 'sequel'
require 'logger'

DB = Sequel.connect("mysql2://sequeltest:sequeltest@db/sequeltest?charset=utf8mb4")
DB.loggers << Logger.new($stdout)

require_relative './models.rb'

vendors = Vendor
            .where(:user_id => 1)
            .eager(:last_edit => proc {|ds| ds.reverse_order(:created_at).clone(:eager_limit => 1) })
            .all

# vendors = Vendor
#             .where(:user_id => 1)
#             .eager(:last_edit => proc {|ds| ds.reverse_order(:created_at) })
#             .all


vendors.each do |v|
  p v.last_edit
  p '-'*50
end
