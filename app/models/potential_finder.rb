class PotentialFinder < PotentialUser
  def after_create
    PotentialUserMailer.deliver_potential_finder_message(email) rescue nil
  end
end