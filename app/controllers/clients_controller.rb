
class ClientsController < ApplicationController
  before_action :find_client, only: [:read_buildings, :create_building, :edit_building]
  before_action :find_building, only: [:edit_building]
  rescue_from ActionController::UnpermittedParameters, with: :handle_unpermitted_parameters
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found


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
    building = @client.buildings.new(building_params)
    save_building(building, 'Building created successfully')
  end

  def edit_building
    @building.assign_attributes(building_params)

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

  def building_params
    permitted_attributes = [:street_address, :city, :state, :zip]
    custom_field_names = @client.custom_fields.pluck(:internal_name).map(&:to_sym)

    custom_fields = params.require(:building).permit(*custom_field_names).to_h
    params.require(:building).permit(*permitted_attributes).merge(custom_fields: custom_fields)
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

  def handle_record_not_found(exception)
    render json: { error: "Record not found: #{exception.message}" }, status: :not_found
  end
end
