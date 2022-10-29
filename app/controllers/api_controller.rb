class ApiController < ApplicationController

    protect_from_forgery :except => [:updateUserData, :updateUserLatLong, :updateUserToken, :uploadImageByUser, :registerUser, :login]

    def getWeatherIcons

        @weathericons = Weathericon.all
        render :json => @weathericons
        
    end

    def getUserData

        @user = User.find(params[:user_id])
        render :json => @user
    end

    def updateUserData

        @user = User.find(params[:user_id])
        @user.name = params[:name]
        @user.email = params[:email]
        @user.save

        render :json => @user

    end

    def login


        @admin = Admin.find_by_email(params[:email])

        if @admin

            if @admin.authenticate(params[:password])


                session[:admin_id] = @admin.id

                redirect_to root_url, notice:"Welcome " + @admin.name 


                
            else


                redirect_to root_url, notice:"Wrong email and password"
            end
        else

            redirect_to root_url, notice:"Admin does not exist"
          
        end

    end

    def updateUserLatLong

        @user = User.find(params[:user_id])
        @user.latitude = params[:latitude]
        @user.longitude = params[:longitude]
        @user.save
    end

    def updateUserToken
        @user = User.find(params[:user_id])
        @user.device_token = params[:device_token]
        @user.save


    end
    def registerUser


        if User.where("unique_va =?",params[:unique_va]).size != 0

            @user = User.where("unique_va =?",params[:unique_va]).first
            render :json => @user
        else

            @user = User.new
            @user.macaddress = params[:macaddress]
            @user.unique_va = params[:unique_va]
            @user.device_token = params[:device_token]
            @user.save

            render :json => @user

        end
      

        



    end

    def getImagesUploaded

        @images = Image.where("created_at >=? AND created_at <=?",DateTime.now.beginning_of_day.in_time_zone,DateTime.now.end_of_day.in_time_zone).reverse

        render :json => @images
    end



    def uploadImageByUser

        @image = Image.new
        @image.user_id = params[:user_id]
        @image.latitude = params[:latitude]
        @image.longitude = params[:longitude]
        data = StringIO.new(Base64.decode64(params[:base64string]))
        @image.picture = data
        @image.compass_value = params[:compass_value]
        @image.altitude = params[:altitude]
        @image.addres = params[:address]
        @image.weathericon_id = params[:weathericon_id]
        @image.comment = params[:comment]
        @image.save

        render :json => @image



    end



    def logout


        session[:admin_id] = nil

        redirect_to root_url, notice:"Come back soon"


    end

end
