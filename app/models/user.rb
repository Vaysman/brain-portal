class User < ActiveRecord::Base
	validates :email, :password, :username, presence: true
	validates :email,  :username, uniqueness: true
	validates :password, confirmation: true
	validates :email, email_format: { message: :email_error }
	validates :username, format: { with: /[a-zA-Z0-9]/,
    message: :username_error }


end
