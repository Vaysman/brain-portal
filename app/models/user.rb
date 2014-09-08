class User < ActiveRecord::Base
	before_create :hash_password, :on => :create
	before_create :token
	belongs_to :group
	validates :email, :password, :username, presence: true
	validates :password, length: { in: 6..14 }, :on =>:create
	validates :email,  :username, uniqueness: true
	validates :password, confirmation: true
	validates :icq, numericality: { only_integer: true }
	validates :email, email_format: { message: :email_error }
	validates :username, format: { with: /[{Cyrillic}a-zA-Z0-9]+$/, multiline: true,
    message: :username_error }
    validates :username, length: {in: 6..14}
    validates :password, format: { with: /[a-zA-Z0-9]+$/, multiline: true,
   	message: :pw_error }

   	def set_new_info (new_params)
   	  if (new_params['birthday(3i)'] && new_params['birthday(2i)'] && new_params['birthday(1i)'])
   	  	self.birthday = Date.civil(new_params['birthday(1i)'].to_i, new_params['birthday(2i)'].to_i, new_params['birthday(3i)'].to_i)
   	  end
   	  if (new_params[:name])
   	  	self.name = new_params[:name]
   	  end
	  
	  if (new_params[:username])
   	  	self.username = new_params[:username]
   	  end

   	  if (new_params[:group_id])
   	  	self.group_id = new_params[:group_id]
   	  end

   	  if (new_params[:skype])
   	  	self.skype = new_params[:skype]
   	  end

   	  if (new_params[:icq])
   	  	self.icq = new_params[:icq]
   	  end

   	  if (new_params[:city])
   	  	self.city = new_params[:city]
   	  end

   	  if (new_params[:country])
   	  	self.country = new_params[:country]
   	  end
   	  if self.save
   	  	
   	  else
   	  	self
   	  end
   	end



   	private
	    def hash_password
	    	self.password = Digest::SHA1.hexdigest(password)
	    end
	    def token
	    	self.active = 0
	    	self.activation_token = Digest::SHA1.hexdigest(Time.now.to_s + self.email)
	    end

end
