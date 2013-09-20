# Public: The AdminUser model handles user authentication for the website. It is
# handled through Devise, and administration happens with ActiveAdmin.
class AdminUser < ActiveRecord::Base

  # Internal: Include default Devise modules. Other modules that are available
  # include: :token_authenticatable, :confirmable, :lockable, :timeoutable,
  # and :omniauthable.
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Internal: Allow mass-assignment.
  attr_accessible :email, :password, :password_confirmation, :remember_me

end
