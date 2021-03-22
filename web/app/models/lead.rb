class Lead < ApplicationRecord
  before_save :normalize_phone

  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP  } 
  validates :phone, phone: true, allow_blank: false

  def parsed_phone
    parsed_phone = Phonelib.parse(phone)
    return phone if parsed_phone.invalid?

    parsed_phone
  end

  def formatted_phone(formatted=true)
    return phone unless parsed_phone.respond_to?(:country_code)

    formatted =
      if parsed_phone.country_code == "1"
        parsed_phone.national formatted
      else
        parsed_phone.full_international formatted
      end
    formatted.gsub!(";", " x")
    formatted
  end

  private

  def normalize_phone
    self.phone = Phonelib.parse(phone).full_e164.presence
  end
end
