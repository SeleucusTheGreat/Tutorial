class Post < ApplicationRecord
    validates :title , presence: true , length: {minimum: 5, maximum: 50}
    validates :body , presence:true , length: {minimum: 50, maximum: 500}
    belongs_to :user
    has_many :comments , dependent: :destroy

    has_noticed_notifications model_name: "Notification"
    has_many :notifications, through: :user 
end
