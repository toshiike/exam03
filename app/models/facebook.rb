class Facebook < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :user
  mount_uploader :image, ImageUploader
end
