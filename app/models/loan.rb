# frozen_string_literal: true

# Class representing a one or more video loan
class Loan < ApplicationRecord
  enum status: { active: 0, finished: 1, delayed: 2 }
  belongs_to :user, counter_cache: :loans_counter
  has_and_belongs_to_many :movies
  validates_datetime :expire_at
  before_validation :calculate_expiration_datetime
  before_validation(on: :create) do
    if Loan.where(status: [0, 2], user_id: user_id).count.positive?
      errors.add :status, "Can't loan more movies while you have an active loan"
      throw :abort
    end
  end
  before_save :calculate_expiration_datetime

  def calculate_expiration_datetime
    self.expire_at = DateTime.now.beginning_of_day + movies.size.days
  end
end
