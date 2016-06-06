#
module Analytics
  class HubspotContactWorker
    include Sidekiq::Worker
    sidekiq_options :queue => :analytics
    def perform(email, hash={})
    hubspot = Analytics::HubspotCrm.new
    unless hubspot.create_hubspot_contact(email,hash)
      hubspot.update_hubspot_contact email,hash
    end
    end
  end
end
