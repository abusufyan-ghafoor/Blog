class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one_attached :image
    validates :post_name, presence: true, length: { minimum: 3, too_short: "%{count} characters is the minimum allowed" }
    validates :post_description, presence: true, length: { minimum: 10, too_short: "%{count} characters is the minimum allowed" }
    # validates :image, file: {ext: [:jpg, :png]}
    validate :image_type
    paginates_per 4

    private

    def image_type
        if image.attached? == false
            errors.add(:image, "is missing!")
        end
        if !image.content_type.in?(%('image/jpeg image/png'))
            errors.add(:image, "needs to be a jpeg or png!")
        end
    end
end
