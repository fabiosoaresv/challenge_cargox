class Coordinator < ApplicationRecord
  has_many :employee
  belongs_to :leader

  def employees
    self.employee
  end
end
