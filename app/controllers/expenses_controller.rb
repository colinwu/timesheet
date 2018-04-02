class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = Expense.order('date DESC').paginate(:page => params[:page])
  end

  def show
  
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(params[:expense])
    if @expense.save
      redirect_to expenses_url, :notice => "Successfully created expense."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @expense.update_attributes(params[:expense])
      redirect_to @expense, :notice  => "Successfully updated expense."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_url, :notice => "Successfully destroyed expense."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def expense_params
    params.require(:expense).permit(:date, :amount, :desc, :money, :project_id, :hst)
  end
end
