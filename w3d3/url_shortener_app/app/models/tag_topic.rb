# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base
  validates :url_id, presence: true

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :topic_id,
    primary_key: :id
  )

  has_many(
    :tagged_urls,
    -> { distinct },
    through: :taggings,
    source: :url
  )

  def most_popular_link
    self.tagged_urls.where
  end
end
