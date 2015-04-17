class Book < ActiveRecord::Base

  belongs_to :genre

  validates :title, presence: true

  scope :finished, -> { where('finished_At IS NOT NULL') }
end
