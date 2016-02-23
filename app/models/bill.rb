class Bill < ActiveRecord::Base
	has_many :services, dependent: :destroy
	has_one :client

	belongs_to :company

	accepts_nested_attributes_for :services
end
