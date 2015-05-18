# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :subs, :author_id, presence: true

  belongs_to :author, class_name: "User"

  has_many :post_subs
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments, dependent: :destroy

  def top_level_comments
    self.comments.where(parent_comment_id: nil)
  end

  def comments_by_parent_id
    comments_by_parent = Hash.new { |h, k| h[k] = [] }

    self.comments.includes(:author).each do |comment|
      comments_by_parent[comment.parent_comment_id] << comment
    end

    comments_by_parent
  end
end
