class UserSerializer < ActiveModel::Serializer

    attributes :id, :macaddress, :name, :email, :latitude, :longitude, :device_token, :unique_va, :images

end