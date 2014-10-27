class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit,:update, :destroy]

  def index
    @contact = Contact.by_letter(params[:letter])
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to contact_path(@contact)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to contact_path(@contact)
    else
      render 'edit'
    end
  end

  def destroy
    @contact.delete
    redirect_to contacts_path
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:firstname, :lastname, :email, phones_attributes: [ :phone, :phone_type ])
    end
end
