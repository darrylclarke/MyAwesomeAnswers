class Question < ActiveRecord::Base
	
	has_many :answers, dependent: :destroy			# need to add this.
	belongs_to :category
	belongs_to :user
	
	 # can put , foreign_key: "the_key_name", but better to use the defaults.
	 # The dependent option is needed because we added a fk constraint to the db so the
	 # dependent records ( in this case answers) must do somethign before deleting a question that they
	 # reference.  The options are:  
	     # :destroy --> deletes all dependent records
		 # :nullify --> will make question_id field null in the db b/f delting the question.
		 
		 
	# # This prevents the record from saving or updating unless a title is provided.
	# validates :title, presence: {message: "Must be present"},
	# 				  # This will check for uniqueness of title / body combination.  Title doesn't have
	# 				  # to be unique by itself, but in combo with body it should.
	# 				  uniqueness: {scope: :body},
	# 				  length: {minimum: 3, message: "this is the message for short" } # this makes sure title is at least 3
					  
	# validates :body,  presence: true
	
	# validates :view_count, presence:     true,
	#                        numericality: {greater_than_or_equal_to: 0 } # and all relate >= <= = > < ops
						   
						   
						   
	# # assignment: 1
	# # Write a validation code that will validate the presence of the name and that price is more than 0 and less than 1000						   
	# validates :title, presence: true
	
	# validates :view_count, presence:  true,
	#                        numericality:  {greater_than: 1,  less_than: 100 }
	
	
	# assignment: 2
	# Write a validation that makes sure that the name is present, unique and that it's not of of those 
	# reserved words: Apple, Microsoft & Sony						   
	validates :title, presence: true,
	                  uniqueness: true	                    
	
	validate :no_reserved_words
	
	
	
	# assignment: 3
	#validates :title, presence: true, uniqueness:true
	
	
	# assignment: 4
		# Given a product model with name, price and sale_price
		# Write a code that sets the sale_price to be equals to the price unless it's been set already. Only on created.
		# Write a validation that ensures that the sale price is not higher than the price.
	# after_initialize :set_sale_price
	# validate         :sale_price_must_not_be_higher_than_price
	
	# private
	
	# def set_sale_price
	# 	self.sale_price ||= price
	# end
	
	# def sale_price_must_not_be_higher_than_price
	# 	if sale_price.present? && price.present? && sale_price > price )
	# 		errors.add(:sale_price, "Sale price cannot be higher than price.")
	# 	end
	# end		
	
	
	
	
	
	# format (ie phone number )  Below is for email ==> see github for exact regex.
	# validates :email, format: /\A[\w+] .../i		
	
	# Use validate for a custom validation method that can do any ruby code
	validate :no_monkey		
	
	after_initialize :set_defaults
	before_save :capitalize_title
	before_destroy :log_message_before_destroy
	
	################### this part
	def self.recent
		order(:created_at).reverse_order             #ascending is default
	end
	
	def self.ten
		limit(10)
	end
	
	scope :recent, lambda {order(:created_at).reverse_order } # These are the same
	scope :recent2, -> {order(:created_at).reverse_order }
	
	def self.recent_ten
		recent.ten
	end
	######################
	
	def self.search( word )
		where( ["title ILIKE ? OR body ILIKE ?", "%#{word}%", "%#{word}%"])
	end
	
	def self.search2( word )
		where( ["title ILIKE :aword OR body ILIKE :aword", {aword: "%#{word}%"}])
	end
	
	def self.unsafe_search( word )
		where( "title ILIKE '%#{word}%' OR body ILIKE '%#{word}%'")
	end
		
	def self.created_after( date )
		where( ["created_at >= :date", date: "#{date}"])
	end
	
	def self.updated_after( date )
		where( ["updated_at >= :date", date: "#{date}"])
	end
	
	def multi( *multi_args )
		multi_args.each { |x| puts x }
	end
	
   def increment_view_count
     self.view_count = view_count + 1
     self.save
   end	

	#delegate :name, to: :category                # @question.name	
	delegate :name, to: :category, prefix: true	  # @question.category_name /w 'category_' prefix
	# def category_name
	# 	category.name
	# end
	
	def user_name
		if user_id
			self.user.first_name + " " + self.user.last_name
		else
			""
		end
	end
	
private

	def no_monkey	
		# This will add to the errors object attachced to the current object
		# if the errors object is not an empty hash then rails treats the record
		# as invalid
		if title.present? && title.downcase.include?("monkey")
			errors.add(:title, "Can't have monkey!")
		end
	end
	
	def no_reserved_words	
		reserved_words = ['Sony', 'Apple', 'Microsoft']
		
		if title.present? 
			title_lower = title.downcase
			
			reserved_words.each do |word|
				print word, " ", title_lower, "\n"
				if title_lower.include?( word.downcase )
					errors.add(:title, "Can't have reserve word:  #{word}!")
				end
			end
			
		end
	end
	
	def set_defaults
		self.view_count ||= 0
	end
	
	def capitalize_title
		self.title.capitalize!	# Will get saved as capitals in the database.
	end
	
	def log_message_before_destroy
		puts "This record is about to be destroyed:  #{self.id}"
		# if /2015\-08\-14/ =~ self.created_at.to_s
		#   false
		# else
		#   true
		# end
	end
end
