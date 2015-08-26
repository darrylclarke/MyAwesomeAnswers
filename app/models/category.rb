class Category < ActiveRecord::Base
	# Choose nullify so that when category is deleted, the questions remain.
	has_many :questions, dependent: :nullify
	
	validates :name, presence: true, uniqueness: true
end
