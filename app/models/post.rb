class Post < ApplicationRecord
  belongs_to :user

  validates :title, :content, :user_id, presence: true
  validates :published, inclusion: { in: [true, false] } # En caso de booleanos asi erste presente con valor false lo tomara como no presente por eso se usa inclusion y no presence
end
