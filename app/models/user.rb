class User < ApplicationRecord
    has_secure_password
    validate :birthday_within_last_100years
    attr_accessor :remember_token

    # Returns the hash digest of the given string.
    def User.digest string
        cost = if ActiveModel::SecurePassword.min_cost
            BCrypt::Engine::MIN_COST
            else
                BCrypt::Engine.cost
                end
                BCrypt::Password.create string, cost: cost
            end
            def self.new_token
                SecureRandom.urlsafe_base64
             end
            def remember
                self.remember_token = User.new_token
                update_column :remember_digest, User.digest(remember_token)
             end
             def forget
                update_column :remember_digest, nil
             end
            def authenticated? remember_token
                BCrypt::Password.new(remember_digest).is_password? remember_token
             end
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
