class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to @contact, :notice => "Successfully created contact."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to @contact, :notice  => "Successfully updated contact."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_url, :notice => "Successfully destroyed contact."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :address)
    end
end
