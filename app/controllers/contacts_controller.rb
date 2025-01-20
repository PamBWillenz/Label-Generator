class ContactsController < ApplicationController
  before_action :set_list
  
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

  def show
    @contact = @list.contacts.find(params[:id])
  end

  def edit
    @contact = @list.contacts.find(params[:id])
  end

  def update
    @contact = @list.contacts.find(params[:id])
    if @contact.update(contact_params)
      redirect_to preview_contacts_list_path(@list), notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @contact = @list.contacts.find(params[:id])
    @contact.destroy
    redirect_to preview_contacts_list_path(@list), notice: 'Contact was successfully destroyed.'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :address_line1, :address_line2, :city, :state, :zip_code)
  end
end
