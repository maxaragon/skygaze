class ImageSerializer < ActiveModel::Serializer

    attributes :id, :icon_url, :addres, :created_at, :latitude, :longitude, :altitude, :compass_value, :comment, :user_id, :picture_url

end