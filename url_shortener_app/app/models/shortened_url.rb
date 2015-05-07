# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#
require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, presence: true, uniqueness: true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many :visitors, -> { distinct }, through: :visits, source: :visitor

  has_many(
    :tag_topics,
    -> { distinct },
    through: :taggings,
    source: :topic
  )

  def self.create_for_user_and_long_url!(user, long_url)
    submitter_id = user.id
    short_url = self.random_code

    ShortenedUrl.create!(
      long_url: long_url,
      submitter_id: submitter_id,
      short_url: short_url
    )
  end

  def self.random_code
    short = SecureRandom::urlsafe_base64(12)

    while ShortenedUrl.exists?(short_url: short)
      short = SecureRandom::urlsafe_base64(12)
    end

    short
  end

  def num_clicks
    self.visits.count
  end

  def num_recent_uniques
    self.visitors.where("visits.created_at > ?", 10.minutes.ago).count
  end

  def num_uniques
    self.visitors.count
  end
end
