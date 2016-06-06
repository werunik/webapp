#
module Analytics
  class HubspotDealWorker
    include Sidekiq::Worker
    sidekiq_options :queue => :analytics
    def perform(email, conversion_id)
      hubspot = Analytics::HubspotCrm.new
      vid = hubspot.hubspot_contact_exists?(email)
      hubspot.create_hubspot_deal(vid, conversion_id) unless vid.nil?
    end
  end
end
