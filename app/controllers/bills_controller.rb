class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_company!

  # GET /bills
  # GET /bills.json
  def index
    @bills = current_company.bills
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    bill = @bill
    result = Billme.bill do
      number bill.gen_name
      filename "Bill printout"

      company do
        logo "logo.png"

        company_name "Enterprise LLC"
        company_address "The Neutral Zone 123"
        company_city "Beta Quadrant"
        company_country "Universe"
        company_phone "+ 123 123 123 1"
        company_email "uss@ncc1701.com"
      end

      client do
        # project_name "Battle engagement"
        name bill.client.name
        date bill.date
        due_date bill.due_date
        address bill.client.address
        email bill.client.email
      end

      services do
        tax "0.25"
        bill.services.each do |s|
          service do
            name s.name
            description s.description
            unit s.amount
            currency s.currency
            quantity s.quantity
          end
        end
      end

      other do
        notice bill.notice
        footer bill.footer
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
      params.require(:bill).permit(:name, :notice, :footer, :date, :due_date, :client_id, services_attributes: [:id, :bill_id, :name, :description, :amount, :currency, :quantity, :_destroy])
    end
end
