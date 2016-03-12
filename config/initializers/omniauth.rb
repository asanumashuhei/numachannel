# 認証
Rails.application.config.middleware.use OmniAuth::Builder do
  # facebook scopeを指定し、使用する権限を明記する必要があります
  provider :facebook,
    Rails.application.secrets.facebook_id,
    Rails.application.secrets.facebook_secret_key,
    scope: 'public_profile, publish_actions'

  # twitter
  provider :twitter,
  Rails.application.secrets.twitter_consumer_key,
  Rails.application.secrets.twitter_consumer_secret
end