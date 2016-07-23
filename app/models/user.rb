class User < ActiveRecord::Base
    
    has_many :posts
    
    # helper methods

	def self.sign_in_from_omniauth(auth)
		find_by(provider: auth['provider'], uid: auth['uid'], profile_image: auth['info']['image']) || create_user_from_omniauth(auth)
	end

	def self.create_user_from_omniauth(auth)
		create(
			provider: auth['provider'],
			uid: auth['uid'],
			name: auth['info']['name'],
			profile_image: auth['info']['image']
			)
	end
end
