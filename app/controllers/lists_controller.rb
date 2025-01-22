class ListsController < ApplicationController
    before_action :set_list, only: [:show, :edit, :update, :destroy, :generate_labels, :preview_contacts, :upload_contacts]
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
        begin
          csv = CSV.read(params[:file].path, headers: true)
          
          # Validate headers
          required_headers = ['First Name', 'Last Name', 'Address Line 1', 'City', 'State', 'Zip Code']
          missing_headers = required_headers - csv.headers.map(&:strip)
          if missing_headers.any?
            raise "Missing required headers: #{missing_headers.join(', ')}"
          end

          csv.each do |row|
            Rails.logger.debug "Processing CSV row: #{row.inspect}"
            
            contact_attributes = {
              first_name: row['First Name']&.strip,
              last_name: row['Last Name']&.strip,
              address_line1: row['Address Line 1']&.strip,
              address_line2: row['Address Line 2']&.strip,
              city: row['City']&.strip,
              state: row['State']&.strip,
              zip_code: row['Zip Code']&.strip
            }
            
            Rails.logger.debug "Attempting to create contact with: #{contact_attributes.inspect}"
            contact = @list.contacts.create!(contact_attributes)
            Rails.logger.debug "Contact created: #{contact.inspect}"
          end
          redirect_to preview_contacts_list_path(@list), notice: "Contacts imported successfully."
        rescue StandardError => e
          Rails.logger.error "Error importing contacts: #{e.message}"
          redirect_to preview_contacts_list_path(@list), alert: "Error importing contacts: #{e.message}"
        end
      else
        redirect_to preview_contacts_list_path(@list), alert: "Please upload a CSV file."
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

