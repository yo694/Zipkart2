class Vendor < ApplicationRecord
  belongs_to :user

  validates :bussiness_name, presence: true
  validates :gst_id , presence: true
  validates :user_id, presence: true , uniqueness: true
end
