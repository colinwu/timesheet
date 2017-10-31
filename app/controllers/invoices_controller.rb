class InvoicesController < ApplicationController
  layout "show_invoice", :only => :show
  
  def index
    @invoices = Invoice.order('invoice_date,paid_date').paginate(:page => params[:page])
  end

  def show
    @invoice = Invoice.find(params[:id])
    @dur = Hash.new
    @sub = Hash.new
    @events = Event.where(["invoice_id = ?", @invoice.id]).order(:start_at)
    @events.each do |e|
      @dur[e.id] = (e.end_at - e.start_at)/3600
      @sub[e.id] = @dur[e.id] * e.rate
    end
    @subtotal = 0
    @sub.each_value do |s|
      @subtotal += s
    end
    @hst = @subtotal * 0.13
    @total = @subtotal + @hst
  end

  # The list of event ids are passed in the Hash params[:select]
  def project_new_or_add
    @project = Project.find params[:id]
    event_list = params[:select]
    if params[:commit] == 'Generate Invoice'
      @invoice = Invoice.create(:invoice_date => Date.today, :project_id => @project.id, :memo => params[:invoice_memo])
    elsif params[:commit] == 'Add to Invoice'
      @invoice = Invoice.find params[:invoice_id]
    end
    unless @invoice.nil?
      event_list.keys.each do |event_id|
        e = Event.find event_id
        e.update_attributes(:invoice_id => @invoice.id)
      end
    end
    redirect_to invoice_url(@invoice)
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    if @invoice.save
      redirect_to @invoice, :notice => "Successfully created invoice."
    else
      render :action => 'new'
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(params[:invoice])
      redirect_to @invoice, :notice  => "Successfully updated invoice."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    redirect_to invoices_url, :notice => "Successfully destroyed invoice."
  end

  def show_project
    p = Project.find params[:id]
    @title = "Invoices for #{p.name}"
    @invoices = Invoice.where(["project_id = ?", p.id]).order('invoice_date,paid_date').paginate(:page => params[:page])
    render :action => 'index'
  end
end
