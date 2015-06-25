# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  url_id     :integer
#  topic_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tagging < ActiveRecord::Base
  validates :url_id, :topic_id, presence: true

  belongs_to(
    :url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id,
  )

  belongs_to(
    :topic,
    class_name: 'TagTopic',
    foreign_key: :topic_id,
    primary_key: :id
  )
end
