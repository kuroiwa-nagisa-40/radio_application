class Station < ApplicationRecord
  has_many :programs, dependent: :destroy
end
