# frozen_string_literal: true

class Movie < ApplicationRecord
  has_one_attached :cover
  has_and_belongs_to_many :loans
  acts_as_taggable_on :categories, :directors, :writers, :actors
  validates :classification, inclusion: { in: %w(G PG PG-13 R NC-17), message: "%{value} is not a movie classification type" }
  validates :title, length: { in: 2..250 }, presence: true, uniqueness: { case_sensitive: false }
  validates_date :release_date
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
  validates :loan_price, numericality: { greater_than: 0 }
  validate :cover_mime_type_size

  private

  def cover_mime_type_size
    errors.add(:cover, 'Cover must be a valid image type') if cover.attached? &&
      !cover.content_type.in?(
        %w(image/jpg image/jpeg image/gif image/png)
      )
  end
end
