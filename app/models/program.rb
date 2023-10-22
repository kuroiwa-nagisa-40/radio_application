class Program < ApplicationRecord
  validates :station, presence: true
  validates :title, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :time, presence: true
end
