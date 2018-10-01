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

            @result = Race.find(params[:race_id]).
                entrants.where(:id => params[:id]).first
            Rails.logger.debug {"found result #{@result}"}
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
            else
                render partial: "result", object: @result
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
