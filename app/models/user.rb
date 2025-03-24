class User < ApplicationRecord
    has_secure_password
    validate :birthday_within_last_100years
    private

    def birthday_within_last_100years
        return unless birthday.present?
        if birthday < 100.years.ago.to_date
            errors.add(:birthday, "must be within the last 100 years")
        end
    end
    
end
