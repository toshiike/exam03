class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :facebook

  has_many :notifications, dependent: :destroy
end
