module Api
    class ResultsController < ApplicationController

        # GET /api/races/:race_id/results
        # GET /api/races/:race_id/results.json
        def index
            render plain: "/api/races/#{params[:race_id]}/results"
        end

        # GET /api/races/:race_id/results/1
        # GET /api/races/:race_id/results/1.json
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
            else
            end
        end

        # POST /api/races/:race_id/results
        # POST /api/races/:race_id/results.json
        def create
            if !request.accept || request.accept == "*/*"
                render plain: :nothing, status: :ok
            else
            end
        end
    end
end
