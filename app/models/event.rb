class Event < ApplicationRecord
  has_many :event_signups, dependent: :destroy
end
