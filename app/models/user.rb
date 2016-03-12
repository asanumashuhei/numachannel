class User < ActiveRecord::Base
  CONSUMER_KEY = "r2BtuXJk4f8vOd0sTzhw4WM5i"
  CONSUMER__SECRET = "mTbXf37wz57x2ZkSKf2qK1RkFdVjRZCoebgKaa9WDnAK1FeXmI"
  ACCESS_TOKEN = "706327101566091264-VmS7eGusyoqtTr1kXHGMNZCdCzvb3tB"
  ACCESS_TOKEN_SECRET = "LCIdqPi3FeD9hvTQ1DP2fVv7HkWaKGYqn2gqIa2zZIfWD"

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:name]
    image_url = auth_hash[:info][:image]

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
    end
  end

  def self.twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = CONSUMER__SECRET
      config.access_token = ACCESS_TOKEN
      config.access_token_secret = ACCESS_TOKEN_SECRET
    end
  end
#   def self.from_omniauth(auth)
#   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
#     user.provider = auth.provider
#     user.uid = auth.uid
#     user.name = auth.info.name
#     user.oauth_token = auth.credentials.token
#     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
#     user.save!
#   end
# end
end
