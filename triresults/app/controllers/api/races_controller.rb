module Api
    class RacesController < ApplicationController

        # GET api/races
        # GET api/races.json
        def index
            render plain: "/api/races"
        end

        # GET api/races/1
        # GET api/races/1.json
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:id]}"
            else
                # render plain: "/api/races/#{params[:id]}"
            end
        end

        # POST api/races
        # POST api/races.json
        def create
            if !request.accept || request.accept == "*/*"
                render plain: :nothing, status: :ok
            else
            end
        end
    end
end
