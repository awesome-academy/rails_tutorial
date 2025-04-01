class User < ApplicationRecord
    has_secure_password
    validate :birthday_within_last_100years, if: -> { birthday.present? }
    attr_accessor :remember_token

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
            errors.add(:birthday,I18n.t( "users.errors.birthday_old"))
        end
    end
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
<<<<<<< HEAD


    validates :gender, inclusion: { in: ['female', 'male', 'other'], allow_blank: true }
<<<<<<< HEAD

    validates :name, presence: true, length: { minimum: 6 }
    validates :password, presence: true, length: { minimum: 6 }, on: :create

=======
>>>>>>> 47472a4 (chapter10)

    validates :name, presence: true, length: { minimum: 6 }
    validates :password, presence: true, length: { minimum: 6 }, on: :create


=======
    validates :gender, inclusion: { in: ['female', 'male', 'other'], allow_blank: true }
    validates :name, presence: true, length: { minimum: 6 }
    validates :password, presence: true, length: { minimum: 6 }, on: :create
>>>>>>> 26773bf (chapter10)
end
