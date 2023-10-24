class Program < ApplicationRecord
  belongs_to :station

  validates :station_id, presence: true
  validates :title, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :time, presence: true
end
