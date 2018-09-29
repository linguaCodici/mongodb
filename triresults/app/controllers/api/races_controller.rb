module Api
    class RacesController < ApplicationController
        def index
            render plain: "/api/races/"
        end
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:_id]}"
            else
                render plain: "/api/races/#{params[:_id]}"
            end
        end
    end
end
