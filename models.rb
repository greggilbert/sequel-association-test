require 'sequel'

class User < Sequel::Model
  one_to_many :vendors
end

# ----

class VendorRevision < Sequel::Model
  many_to_one :vendor
end

VendorRevision.plugin :timestamps, update_on_create: true

# ----

class Vendor < Sequel::Model
  one_to_many :vendor_revisions, class: VendorRevision
  many_to_one :user
end

Vendor.one_to_one :last_edit, :class => :VendorRevision, :update_on_create => true
