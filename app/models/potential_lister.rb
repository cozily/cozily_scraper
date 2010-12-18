class PotentialLister < PotentialUser
  def after_create
    PotentialUserMailer.deliver_potential_lister_message(email) rescue nil
  end
end
