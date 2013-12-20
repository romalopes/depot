require 'chronic'

class Product < ActiveRecord::Base
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
end

