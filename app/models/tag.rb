class Tag < ActiveRecord::Base
	has_many :categorizations 
	has_many :posts, through: :categorizations
end
