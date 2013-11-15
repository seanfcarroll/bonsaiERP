class LoansReceivesController < ApplicationController

  # GET /loans_receive
  def index
    @loans = Loans::Receive.includes(:loan_extra, :contact).page(@page)
  end

  # GET /loans_receive/new
  def new
    @loan = Loans::Form.new_receive(date: Date.today, due_date: Date.today)
  end

  # POST /loans_receive
  def create
     @loan = Loans::Form.new_receive(loan_params)

     if @loan.create
        redirect_to @loan.loan
     else
       render :new
     end
  end

  # GET /loans/:id
  def show
    @loan = Loans::Receive.find(params[:id])
  end

  private

    def loan_params
      params.require(:loans_form).permit(
        :contact_id, :date, :due_date, :account_to_id, :total, :reference
      )
    end
end
