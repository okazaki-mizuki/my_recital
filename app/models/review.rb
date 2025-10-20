class Review < ApplicationRecord
  belongs_to :user

  validates :orchestra, presence: true
  validates :impression, presence: true
end
