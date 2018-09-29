module Api
    class RacersController < ApplicationController

        # GET api/racers
        # GET api/racers.json
        def index
            render plain: "/api/racers"
        end

        # GET api/racers/1
        # GET api/racers/1.json
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/racers/#{params[:id]}"
            else
                # render plain: "/api/racers/#{params[:id]}"
            end
        end
    end
end
