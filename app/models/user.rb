class User < ApplicationRecord
    # ——————————————————————————
    # Attribute macros
    has_secure_password
    attr_accessor :remember_token, :activation_token, :reset_token
  
    # ——————————————————————————
    # Associations
    has_many :microposts, dependent: :destroy
  
    has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
  
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
  
    # ——————————————————————————
    # Validations
    validate  :birthday_within_last_100years, if: -> { birthday.present? }
    validates :name,     presence: true, length: { minimum: 6 }
    validates :email,    presence: true, uniqueness: true
    validates :gender,   inclusion: { in: %w[female male other], allow_blank: true }
    validates :password, presence: true, length: { minimum: 6 }, on: :create

    # ——————————————————————————
    # Callbacks
    before_create :create_activation_digest

    # ——————————————————————————
    # Class methods
    def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def self.new_token
      SecureRandom.urlsafe_base64
    end

    # ——————————————————————————
    # Instance methods

    # Remember user session
    def remember
      self.remember_token = User.new_token
      update_column(:remember_digest, User.digest(remember_token))
    end

    def forget
      update_column(:remember_digest, nil)
    end

    # Account activation
    def activate
      update_columns(activated: true, activated_at: Time.zone.now)
    end

    def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end

    # Token authentication
    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false unless digest
      BCrypt::Password.new(digest).is_password?(token)
    end

    # Password reset
    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end

    def create_reset_digest
      self.reset_token = User.new_token
      update_columns(
        reset_digest: User.digest(reset_token),
        reset_sent_at: Time.zone.now
      )
    end

    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now
    end

    # Feed
    def feed
        Micropost.where(user_id: following_ids + [id])
      end

    # ——————————————————————————
    # Follow/unfollow methods
  
    def follow(other_user)
      following << other_user unless self == other_user
    end

    def unfollow(other_user)
      following.delete(other_user)
    end

    def following?(other_user)
      following.include?(other_user)
    end

    # ——————————————————————————
    # Private methods
    private

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
      puts "Creating activation token: #{activation_token}"
    end
    def birthday_within_last_100years
      return unless birthday.present?
      if birthday < 100.years.ago.to_date
        errors.add(:birthday, I18n.t("users.errors.birthday_old"))
      end
    end
  end
  