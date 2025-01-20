class ListsController < ApplicationController
    before_action :set_list, only: [:show, :edit, :update, :destroy, :generate_labels, :preview_contacts]
    def index
      @lists = List.all
    end
    def edit
    end

    def update
      if @list.update(list_params)
        redirect_to @list, notice: 'List updated successfully.'
      else
        render :edit
      end
    end

    def show
      #@list = List.find(params[:id])
      @contacts = @list.contacts
    end
    def new
      @list = List.new
    end
    def create
      @list = List.new(list_params)
      if @list.save
        redirect_to @list, notice: 'List created successfully.'
      else
        render :new
      end
    end
    def generate_labels
      label_type = params[:label_type] || "Avery5160"
      label_pdf = LabelGenerator.new(@list, label_type).generate
      send_data label_pdf,
                filename: "#{@list.name.parameterize}_labels.pdf",
                type: "application/pdf",
                disposition: "attachment"
    end

    def upload_contacts
      if params[:file].present?
        Contact.import_from_csv(params[:file], @list)
        redirect_to preview_contacts_list_path(@list), notice: "Contacts imported successfully."
      else
        redirect_to preview_contacts_list_path(@list), notice: "Please upload a csv file."
      end
    end

    def preview_contacts
      @contacts = @list.contacts
    end

    def destroy
      @list.destroy
      redirect_to lists_url, notice: 'List deleted successfully.'
    end
    private
    def set_list
      @list = List.find(params[:id])
    end
    def list_params
      params.require(:list).permit(:name, :description)
    end
end

