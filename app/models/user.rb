class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable

  has_many(
    :comments,
    inverse_of: :user
  )

  has_many(
    :posts,
    inverse_of: :user
  )

  before_create :add_default_role

  validates :role, presence: true
  validates :name, presence: true, uniqueness: true

  validates :accept_gdpr, acceptance: { accept: true, message: :gdpr_accept }, on: :create

  def role_human
      VirtualModel::UserRole.find(role).title
  end

  private

  def add_default_role
    (self.role = 9) if self.role.blank?
  end

end
