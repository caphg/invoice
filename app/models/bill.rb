class Bill < ActiveRecord::Base
	CURRENCIES = {'$' => 'USD', 'HRK' => 'HRK'}

	has_many :services, dependent: :destroy
	belongs_to :client

	belongs_to :company

	STATUSES = {PENDING: 1, FINISHED: 2}

	accepts_nested_attributes_for :services, reject_if: :all_blank, allow_destroy: true

	validates :client, presence: true
	validates :services, presence: true
	validates :date, presence: true
	validates :due_date, presence: true
	validates :currency, presence: true

	before_create do
		self.status = STATUSES[:PENDING]
		self.name = gen_name
		unless self.currency == 'HRK'
			response = RestClient.get 'http://hnbex.eu/api/v1/rates/daily/'
			JSON.parse(response.body).each do |c|
				if c["currency_code"] == CURRENCIES[self.currency]
					self.convertion_rate = c["median_rate"].to_f
				end
			end
		end
	end

	# TODO: bill place and cashier id to be fetched from DB
	def gen_name
		last_id = Bill.last ? Bill.last.id + 1 : 1
		"#{last_id}-1-1"
	end

	def current_name
		"#{Bill.last.id}-1-1"
	end
end
