module Crm
  # class hubspot
  class Hubspot
    DEAL_STAGE  = :appointmentscheduled
    DEAL_TYPE   = :newbusiness
    PORTAL_ID   = 2281190
    COMPANY_ID  = nil

    # def initialize
    #   Hubspot.configure(hapikey: '327a107b-0ea0-45af-97c8-d0fa33560b49')
    # end

    def create_hubspot_contact(email, contact_information = {})
      created = true
      begin
        Hubspot::Contact.create!(email, contact_information)
      rescue
        created = false
      end
      created
    end

    def get_hubspot_contact(email)
      return nil unless hubspot_contact_exists?(email).nil?
      Hubspot::Contact.find_by_email(email)
    end

    def update_hubspot_contact(email, hash = {})
      return nil if hubspot_contact_exists?(email).nil?
      hubspot_user = Hubspot::Contact.find_by_email(email)
      hubspot_user.update!(hash)
    end

    def get_xor_create_hubspot_contact(email, contact_information = {})
      create_hubspot_contact(email, contact_information) if hubspot_contact_exists?(email).nil?
      Hubspot::Contact.find_by_email(email)
    end

    def update_contact_conversion_count(email, destination)
      return unless hubspot_contact_exists? email
      hubspot_user = get_hubspot_contact(email)
      if destination == 'objective-c#android'
        objc2android_conversion_count = hubspot_user['conversions_objectivec_to_android'].to_i + 1
        hash = { conversions_objectivec_to_android: objc2android_conversion_count }
      elsif destination == 'objective-c#swift'
        objc2swift_conversion_count = hubspot_user['conversions_objectivec_to_swift'].to_i + 1
        hash = { conversions_objectivec_to_swift: objc2swift_conversion_count }
      end
      update_hubspot_contact(email, hash)
    end

    def hubspot_contact_exists?(email)
      begin
        hubspot_user = Hubspot::Contact.find_by_email(email)
        vid = hubspot_user.vid
      rescue
        vid = nil
      end
      vid
    end

    def create_hubspot_deal(vid, project_id)
      hash = {  dealname: "Deal ##{project_id}",
                dealstage: DEAL_STAGE,
                dealtype: DEAL_TYPE
              }
      Hubspot::Deal.create!(PORTAL_ID, COMPANY_ID, vid, hash)
    end
  end
end
