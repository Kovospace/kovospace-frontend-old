class Contact < ActiveRecord::Base

    attr_accessor :i_am_not_sputnik

    validates :sender, presence: true, :format => { :with => Devise::email_regexp }
    validates :msg, presence: true
    validates :accept_gdpr, acceptance: { accept: true }



end
