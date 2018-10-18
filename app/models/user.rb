# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  has_one_attached :avatar
  has_many :loans, dependent: :restrict_with_exception
  validates :first_name, presence: true, length: { in: 2..60 }
  validate :avatar_mime_type_size

  private

  def avatar_mime_type_size
    errors.add(:avatar, 'invalid image type') if avatar.attached? &&
      !avatar.content_type.in?(
        %w[image/jpg image/jpeg image/gif image/png]
      )
  end
end
