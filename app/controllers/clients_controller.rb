
class ClientsController < ApplicationController
  before_action :find_client, only: [:read_buildings, :create_building, :edit_building]
  before_action :find_building, only: [:edit_building]
  rescue_from ActionController::UnpermittedParameters, with: :handle_unpermitted_parameters


  def read_buildings
    begin
      buildings = @client.buildings.page(params[:page]).per(params[:per_page] || 25)

      render json: {
        status: "success",
        data: { buildings: ActiveModelSerializers::SerializableResource.new(buildings, each_serializer: BuildingSerializer) },
        current_page: buildings.current_page,
        total_pages: buildings.total_pages,
        total_count: buildings.total_count
      }
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Client not found" }, status: :not_found
    end
  end

  def create_building
    building = @client.buildings.new(create_building_params)
    save_building(building, 'Building created successfully')
  end
  def edit_building
    @building.assign_attributes(edit_building_params)

    if @building.valid?
      save_building(@building, 'Building updated successfully')
    else
      render_errors(@building)
    end
  end

  private

  def find_client
    @client = Client.find(params[:id])
  end

  def find_building
    @building = Building.find(params[:building][:id])
  end

  def create_building_params
    custom_fields_params = params.require(:building).permit(*@client.custom_fields.pluck(:internal_name)).to_h
    building_params = params.require(:building).permit(:street_address, :city, :state, :zip)
    building_params.merge(custom_fields: custom_fields_params)
  end

  def edit_building_params
    begin
      # Define which attributes are permitted
      permitted_attributes = [:street_address, :city, :state, :zip]
      
      # Dynamically include custom field names associated with the client
      custom_field_names = @client.custom_fields.pluck(:internal_name).map(&:to_sym)
      
      # Permit basic attributes and dynamically created custom fields
      params.require(:building).permit(*permitted_attributes, *custom_field_names).tap do |permitted|
        # Ensure `custom_fields` are properly nested within the hash
        custom_fields_hash = {}
        custom_field_names.each do |field_name|
          if params[:building].key?(field_name)
            custom_fields_hash[field_name] = params[:building][field_name]
          end
        end
        permitted[:custom_fields] = custom_fields_hash unless custom_fields_hash.empty?
      end
    rescue ActionController::UnpermittedParameters => e
      # Handle unpermitted parameters error gracefully
      render json: { error: "Unpermitted parameters: #{e.params.join(', ')}" }, status: :unprocessable_entity
    end
  end

  def save_building(building, success_message)
    if building.save
      render json: { data: BuildingSerializer.new(building), message: [success_message], status: 201, type: 'Success' }, status: :created
    else
      render_errors(building)
    end
  end

  def render_errors(building)
    render json: { errors: building.errors.full_messages, status: 422, type: 'Error' }, status: :unprocessable_entity
  end

  def handle_unpermitted_parameters(exception)
    render json: { error: "Unpermitted parameters: #{exception.params.join(', ')}" }, status: :unprocessable_entity
  end
end
