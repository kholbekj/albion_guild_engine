json.extract! event_signup, :id, :created_at, :updated_at
json.url event_signup_url(event_signup, format: :json)