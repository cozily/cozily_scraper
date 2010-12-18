class PotentialUserMailer < ActionMailer::Base
  def potential_lister_message(email)
    from "michael@cozi.ly"
    recipients email
    subject "List your apartment on Cozily"
  end

   def potential_finder_message(email)
    from "michael@cozi.ly"
    recipients email
    subject "Find your apartment on Cozily"
  end
end
