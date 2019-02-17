class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :articles, dependent: :nullify

  validates :role, presence: true,
                  inclusion: { in: ['user', 'editor', 'admin'] }

  has_one :oauth_profile, dependent: :destroy
  accepts_nested_attributes_for :oauth_profile
  def self.from_omniauth(access_token)
    uid = access_token['uid']
    provider = access_token['provider']
    data = access_token.info
    user = User.joins(:oauth_profile).find_by(oauth_profiles: { uid: uid })
    user ||= User.create(
      email: data['email'],
      oauth_profile_attributes: {
        provider: provider,
        uid: uid
      },
      password: Devise.friendly_token[0, 20]
    )
    user
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
