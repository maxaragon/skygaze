class Image < ApplicationRecord

    belongs_to :user


    has_attached_file :picture
    validates_attachment_size :picture, :less_than => 100.megabytes
    validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpeg', 'application/pdf']

    

    def picture_url

        picture_url = self.picture.url
    end


    def icon_url
        if self.weathericon_id != 0
            icon_url = Weathericon.find(self.weathericon_id).icon.url
        else

            icon_url = ""

        end
    end


end
