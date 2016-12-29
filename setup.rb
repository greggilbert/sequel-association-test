require 'mysql2'
require 'sequel'
require 'logger'

DB = Sequel.connect("mysql2://sequeltest:sequeltest@db/sequeltest?charset=utf8mb4")
DB.loggers << Logger.new($stdout)

require_relative './models.rb'

u1 = User.new(:email => 'test@example.com', password_hash: 'foo')
u1.save

u2 = User.new(:email => 'test2@example.com', password_hash: 'foo')
u2.save

v1 = Vendor.new(:user_id => u1.id)
v1.save

v2 = Vendor.new(:user_id => u1.id)
v2.save

v3 = Vendor.new(:user_id => u2.id)
v3.save

vr1 = VendorRevision.new(:vendor_id => v1.id, :name => 'Test one')
vr1.save

vr3 = VendorRevision.new(:vendor_id => v2.id, :name => 'Test three')
vr3.save

sleep 1

vr2 = VendorRevision.new(:vendor_id => v1.id, :name => 'Test two')
vr2.save

vr4 = VendorRevision.new(:vendor_id => v2.id, :name => 'Test four')
vr4.save
