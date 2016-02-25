class Client < ActiveRecord::Base
	has_many :bills
	belongs_to :company
end
