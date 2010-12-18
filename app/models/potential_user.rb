class PotentialUser < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_presence_of :type
  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i

  class << self
    def latest_remailer_user
      PotentialUser.first(:conditions => [%Q{email LIKE ?}, '%@craigslist.org'], :order => "created_at desc")
    end
  end
end
