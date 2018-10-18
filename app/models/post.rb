class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(attribute_hash)
    attribute_hash.each do |index, attributes|
      category = Category.find_or_create_by(name: attributes["name"])
        self.post_categories.build(:category => category)
    end
  end

  def unique_commentors
    users = self.comments.collect do |comment|
      comment.user
    end
    users.uniq
  end
end
