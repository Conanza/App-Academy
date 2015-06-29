# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime
#  updated_at        :datetime
#  parent_comment_id :integer
#

class Comment < ActiveRecord::Base
  default_scope { order(id: :desc) }
  validates :content, presence: true
  validates :author, :post, presence: true

  belongs_to :author, class_name: "User"
  belongs_to :post

  belongs_to :parent_comment, class_name: "Comment"
  has_many :child_comments, class_name: "Comment", foreign_key: :parent_comment_id

  has_many :votes, as: :votable

  def vote_score
    self.votes.map(&:value).inject(0, :+)
  end
end
