class Foundator < ApplicationRecord
  has_many :companies
  has_one :leader
end
