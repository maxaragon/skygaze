class Weathericon < ApplicationRecord


    has_attached_file :icon
    validates_attachment_size :icon, :less_than => 100.megabytes
    validates_attachment_content_type :icon, :content_type => ['image/jpeg', 'image/png', 'image/jpeg', 'application/pdf']



    def icon_url
        if self.icon
                icon_url = self.icon.url
        else
            icon_url = ""

        end
    end


end
