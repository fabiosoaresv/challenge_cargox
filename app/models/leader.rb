class Leader < ApplicationRecord
  belongs_to :foundator
  has_many :coordinators
end
