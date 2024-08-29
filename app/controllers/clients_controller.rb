
class ClientsController < ApplicationController
  def read_buildings
    client = Client.find(params[:id])
    buildings = client.buildings.page(params[:page]).per(params[:per_page] || 25)

    render json: {
      status: "success",
      buildings: ActiveModelSerializers::SerializableResource.new(buildings, each_serializer: BuildingSerializer),
      current_page: buildings.current_page,
      total_pages: buildings.total_pages,
      total_count: buildings.total_count
    }
  end

  def create_building
    client = Client.find(params[:id])
    building = client.buildings.build(building_params(client))

    if building.save
      render json: { data: BuildingSerializer.new(building), message: ['Building created successfully'], status: 201, type: 'Success' }, status: :created
    else
      render json: { errors: building.errors.full_messages, status: 422, type: 'Error' }, status: :unprocessable_entity
    end
  end

  private

  def building_params(client)
    permitted_attributes = [:street_address, :city, :state, :zip]
    custom_field_names = client.custom_fields.pluck(:internal_name).map(&:to_sym)
    custom_fields = params.require(:building).permit(*custom_field_names).to_h

    params.require(:building).permit(*permitted_attributes).merge(custom_fields: custom_fields)
  end

end
