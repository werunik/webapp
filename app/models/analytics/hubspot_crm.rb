module Analytics
  # class hubspot
  class HubspotCrm
    DEAL_STAGE  = :appointmentscheduled
    DEAL_TYPE   = :newbusiness
    PORTAL_ID   = 685_406
    COMPANY_ID  = nil

    def initialize
      Hubspot.configure(hapikey: '')
    end

    def create_hubspot_contact(email, contact_informationd = {})
      created = true
      begin
        Hubspot::Contact.create!(email, contact_informationd)
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

    def get_xor_create_hubspot_contact(email, contact_informationd = {})
      create_hubspot_contact(email, contact_informationd) if hubspot_contact_exists?(email).nil?
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

    def create_hubspot_deal(vid, conversion_id)
      hash = {  dealname: "Full Service ##{conversion_id}",
                dealstage: DEAL_STAGE,
                dealtype: DEAL_TYPE
              }
      Hubspot::Deal.create!(PORTAL_ID, COMPANY_ID, vid, hash)
    end
  end
end
