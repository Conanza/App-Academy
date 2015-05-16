# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  author_id  :integer          not null
#  post_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :author, :post, presence: true

  belongs_to :author, class_name: "User"
  belongs_to :post
end
