require 'chronic'

class Product < ActiveRecord::Base

#	default_scope :order => 'title'
	default_scope { order('title') }

	has_many :line_items
	has_many :orders, :through => :line_items
	
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :image_url,  :date_creation, :presence => true
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
	validates :title, :uniqueness => true

	validate :valid_date?
	
	validates :image_url, :format => {
		# :with	=> %r{\.(gif|jpg|png)},
		:with	=> %r{\.(gif|jpg|png)}i,

		:message => '%{value} must be a URL for GIF, JPG or PNG image.'
	}


  	def valid_date?
    	unless Chronic.parse(date_creation)
    		puts date_creation
      		errors.add(:date_creation, "is missing or invalid")
  		end
  	end

	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors.add(:base, 'Line Items present' )
			return false
		end
	end
end