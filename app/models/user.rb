class User < ActiveRecord::Base
   has_attached_file :avatar
   validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	before_create :hash_password, :on => :create
	before_create :token
	belongs_to :group
   belongs_to :check_online
	validates :email, :password, :username, presence: true
	validates :password, length: { in: 6..14 }, :on =>:create
	validates :email,  :username, uniqueness: true
	validates :password, confirmation: true
	validates :icq, numericality: { only_integer: true, :allow_blank => true }
	validates :email, email_format: { message: :email_error }
	validates :username, format: { with: /[{Cyrillic}a-zA-Z0-9]+$/, multiline: true,
    message: :username_error }
    validates :username, length: {in: 6..14}
    validates :password, format: { with: /[a-zA-Z0-9]+$/, multiline: true,
   	message: :pw_error }

   	def set_new_info (new_params)
   	  if (!new_params['birthday(3i)'].empty? && !new_params['birthday(2i)'].empty? && !new_params['birthday(1i)'].empty?)
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

        if (new_params[:sex])
         self.sex = new_params[:sex]
        end

        if (new_params[:about])
         self.about = new_params[:about]
        end

        if (new_params[:avatar])
         self.avatar = new_params[:avatar]
         self.avatar_file_name = Digest::SHA1.hexdigest(Time.now.to_s+username)
        end
        if (new_params[:delete_avatar])
         self.avatar = nil
        end
   	  if self.save
   	  	
   	  else
   	  	self
   	  end
   	end

       def check_online
         @last_move = CheckOnline.find_by(:user_id => id)
         @last_move.time
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
