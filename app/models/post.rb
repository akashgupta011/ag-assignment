class Post < ApplicationRecord
  belongs_to :user # model associated with user model

  #applying condition that title and content must be there
  validates :title, presence: true
  validates :content, presence: true
end
