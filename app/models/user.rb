class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many(
    :comments,
    inverse_of: :user
  )

  has_many(
    :posts,
    inverse_of: :user
  )

  validates :role, presence: true

  def role_human
      VirtualModel::UserRole.find(role).title
  end

end
