module Api
    class EntriesController < ApplicationController

        # GET /api/racers/:racer_id/entries
        # GET /api/racers/:racer_id/entries.json
        def index
            render plain: "/api/racers/#{params[:racer_id]}/entries"
        end

        # GET /api/racers/:racer_id/entries/1
        # GET /api/racers/:racer_id/entries/1.json
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
            else
            end
        end

        # POST /api/racers/:racer_id/entries
        # POST /api/racers/:racer_id/entries.json
        def create
            if !request.accept || request.accept == "*/*"
                render plain: :nothing, status: :ok
            else
            end
        end
    end
end
