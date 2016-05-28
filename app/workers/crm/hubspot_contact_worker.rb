#
module Crm
  class HubspotContactWorker
    include Sidekiq::Worker
    sidekiq_options :queue => :crm
    def perform(email, hash={})
      hubspot = Crm::Hubspot.new
      unless hubspot.create_hubspot_contact(email,hash)
        hubspot.update_hubspot_contact email,hash
      end
    end
  end
end