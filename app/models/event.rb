class Event < ApplicationRecord
  has_many :participations
  has_many :event_items

  accepts_nested_attributes_for :participations

end
