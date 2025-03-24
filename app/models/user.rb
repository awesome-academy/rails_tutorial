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
    validates :name, presence: true

    
    validates :email, presence: true, uniqueness: true
                      
    
  
    validates :gender, presence: true, inclusion: { in: ['female', 'male', 'other'] }
   
end
