class ContactsController < ApplicationController
  before_action :set_list
  before_action :set_contact, only: [:edit, :update, :destroy]

  def new
    @contact = @list.contacts.build
  end

  def create
    @contact = @list.contacts.build(contact_params)
    if @contact.save
      redirect_to preview_contacts_list_path(@list), notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to preview_contacts_list_path(@list), notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to preview_contacts_list_path(@list), notice: 'Contact was successfully destroyed.'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_contact
    @contact = @list.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :address_line1, :address_line2, :city, :state, :zip_code)
  end
end
