class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_company!
  before_action :set_locale

  # GET /bills
  # GET /bills.json
  def index
    @bills = current_company.bills
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    bill = @bill
    paramz = params
    c = current_company
    result = Billme.bill do
      number bill.name
      filename "Bill printout"

      company do
        logo "logo.png"

        company_name c.name
        company_address c.address
        company_city c.city
        company_country c.country
        company_phone c.phone
        company_email c.email
        vat c.vat
        iban c.iban
        swift c.swift
      end

      client do
        # project_name "Battle engagement"
        name bill.client.name
        date bill.date.try(:in_time_zone, c.time_zone)
        due_date bill.due_date.try(:in_time_zone, c.time_zone)
        bill_date bill.created_at.try(:in_time_zone, c.time_zone)
        address bill.client.address
        email bill.client.email
        vat bill.client.vat
      end

      services do
        tax c.tax
        currency bill.currency
        bill.services.each do |s|
          service do
            name s.name
            description s.description
            unit s.amount.round(2)
            quantity s.quantity
          end
        end
      end

      other do
        notice bill.convertion_rate.present? ? "1 #{bill.currency} = #{bill.convertion_rate} HRK | TOTAL(HRK): #{(bill.services.reduce(0){|sum, service| sum + service.amount * service.quantity } * bill.convertion_rate).round(2)  }   #{bill.notice}" : bill.notice
        footer bill.footer
        payment_method paramz[:locale] == 'hr' ? "Transakcijski racun" : "Transactional account"
        operator c.operator
        pay_number bill.name
      end
    end
    render inline: result
  end

  # GET /bills/new
  def new
    @bill = Bill.new
    @bill.services.build
  end

  # GET /bills/1/edit
  def edit
    @bill.services.build
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)
    @bill.company = current_company

    respond_to do |format|
      if @bill.save
        format.html { redirect_to edit_bill_path(@bill), notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to edit_bill_path(@bill), notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.where(id: params[:id], company_id: current_company.id).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:name, :notice, :currency, :footer, :date, :due_date, :client_id, services_attributes: [:id, :bill_id, :name, :description, :amount, :currency, :quantity, :_destroy])
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
end
