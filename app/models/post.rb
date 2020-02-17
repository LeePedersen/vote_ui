class Post < ApplicationRecord
  has_many :replies, dependent: :destroy
end
