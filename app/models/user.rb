class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :subscription_type, presence: true, inclusion: { in: [1,2,3] }
  has_many :api_keys


  def keys_limit_reached?
    key_limit.present? && keys_limit >= api_keys.count
  end

  def keys_limit
    { 1: 5, 2: 10, 3: nil }[subscription_type]
  end

  def api_calls_limit
  end

end
