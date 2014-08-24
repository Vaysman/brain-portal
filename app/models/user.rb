class User < ActiveRecord::Base
	before_save :hash_password, :on => :create
	before_save :token, :on => :create
	validates :email, :password, :username, presence: true
	validates :password, length: { in: 6..14 }
	validates :email,  :username, uniqueness: true
	validates :password, confirmation: true
	validates :email, email_format: { message: :email_error }
	validates :username, format: { with: /[{Cyrillic}a-zA-Z0-9]+$/, multiline: true,
    message: :username_error }
    validates :username, length: {in: 6..14}
    validates :password, format: { with: /[a-zA-Z0-9]+$/, multiline: true,
   	message: :pw_error }

   	private
	    def hash_password
	    	self.password = Digest::SHA1.hexdigest(password)
	    end
	    def token
	    	self.active = 0
	    	self.activation_token = Digest::SHA1.hexdigest(Time.now.to_s + self.email)
	    end

end
