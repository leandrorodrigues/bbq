class Participation < ApplicationRecord
  has_and_belongs_to_many :event_items
  belongs_to :event
  belongs_to :user
end
