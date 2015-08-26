class User < ActiveRecord::Base
	has_secure_password  # password must be there and password_confirmation	has to match
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	
	validates	:email, presence: true, uniqueness: true,
						format: VALID_EMAIL_REGEX
end