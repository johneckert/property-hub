
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

end
