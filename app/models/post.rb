class Post < ApplicationRecord
    extend FriendlyId
    validates :title , presence: true , length: {minimum: 5, maximum: 50}
    validates :body , presence:true , length: {minimum: 50, maximum: 500}
    belongs_to :user
    has_many :comments , dependent: :destroy


    has_noticed_notifications model_name: "Notification"
    has_many :notifications, through: :user 

    def self.ransackable_attributes(auth_object = nil)
        [ "body", "id", "id_value", "title", "updated_at", "user_id", "views"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["comments",  "user"]
    end

    friendly_id :title, use: %i[slugged history]

    def should_generate_new_friendly_id?
        title_changed? || slug.blank?
    end
end
