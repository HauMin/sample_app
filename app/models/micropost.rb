class Micropost < ApplicationRecord
  belongs_to :user
  scope :newest, ->{order created_at: :desc}
  scope :of_following, ->(ids){where user_id: ids}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content_length}
  validate  :picture_size

  private

  def picture_size
    if picture.size > Settings.n_5.megabytes
      errors.add(:picture, I18n.t("size_pic"))
    end
  end
end
