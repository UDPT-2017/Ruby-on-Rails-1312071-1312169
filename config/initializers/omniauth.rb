OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "1130075420411957", "7c2f44f5c6054f141768a5a3aaa910ec"
end
