class BuildingSerializer < ActiveModel::Serializer
  attributes :id, :client_name, :street_address, :city, :state, :zip

  def client_name
    object.client.name if object.client
  end

  def attributes(*args)
    hash = super
    hash.merge!(object.custom_fields || {})
  end
end

