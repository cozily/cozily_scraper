class Post < ActiveRecord::Base
  validates_uniqueness_of :external_id, :href
  validates_presence_of :user

  def after_create
    return if email.blank? || email =~ /craigslist/
#    remailer = PotentialUser.latest_remailer_user
#    return if email =~ /craigslist/ && remailer && remailer.created_at > 10.minutes.ago
    if user == "lister"
      PotentialLister.create(:email => email)
    else
      PotentialFinder.create(:email => email)
    end
  end
end
