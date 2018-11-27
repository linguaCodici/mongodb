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

        # POST api/racers
        # POST api/racers.json
        def create
            if !request.accept || request.accept == "*/*"
                render plain: :nothing, status: :ok
            else
            end
        end
    end
end
