class Bill < ActiveRecord::Base
	has_many :services, dependent: :destroy
	belongs_to :client

	belongs_to :company

	STATUSES = {PENDING: 1, FINISHED: 2}

	accepts_nested_attributes_for :services, reject_if: :all_blank, allow_destroy: true

	before_create do
		self.status = STATUSES[:PENDING]
		self.name = gen_name
	end

	def gen_name
		last_id = Bill.last ? Bill.last.id + 1 : 1
		"#{last_id}-1-1"
	end
end
