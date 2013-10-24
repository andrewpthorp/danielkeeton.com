# Public: The Admin model handles user authentication for the website. It is
# handled through Devise.
class Admin < ActiveRecord::Base
  self.table_name = 'admin_users'

  # Internal: Include default Devise modules. Other modules that are available
  # include: :token_authenticatable, :confirmable, :lockable, :timeoutable,
  # and :omniauthable.
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

end
