module Api
    class RacersController < ApplicationController

        # GET api/racers
        # GET api/racers.json
        def index
            render plain: "/api/racers/"
        end

        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/racers/#{params[:id]}"
            else
            end
        end
    end
end
