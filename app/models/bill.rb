class Bill < ActiveRecord::Base
	has_many :services, dependent: :destroy
	has_one :client

	belongs_to :company

	accepts_nested_attributes_for :services

	STATUSES = {PENDING: 1, FINISHED: 2}

	before_create do
		self.status = STATUSES[:PENDING]
		self.name = "#{Bill.last.id}-1-1"
	end
end
