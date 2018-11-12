# frozen_string_literal: true

class LoanSerializer < ActiveModel::Serializer
  attributes :id, :expire_at, :status, :created_at, :updated_at
  has_many :movies
end
