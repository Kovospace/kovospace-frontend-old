class Contact < ActiveRecord::Base

    attr_accessor :i_am_not_sputnik

    validates(
        :sender,
        presence: true,
        :format => {
            :with => Devise::email_regexp,
            :message => :bad_format
        }
    )

    validates :msg, presence: true

    validates :accept_gdpr, acceptance: { accept: true, message: :gdpr_accept }

    validate do |contact|
      if contact.i_am_not_sputnik == "0"
        contact.errors.add(:i_am_not_sputnik, :i_am_kokot)
      end
    end

end
