
def create_oauth_user(provider, user)
  OmniAuth.config.mock_auth[provider] = {
    "uid" => user.uid,
    "provider" => provider.to_s,
    "info" => {
      "name" => user.name
    }
  }
end
