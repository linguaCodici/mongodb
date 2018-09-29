module Api
    class ResultsController < ApplicationController
        def index
            render plain: "/api/races/#{params[:race_id]}/results"
        end
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
            else
            end
        end
    end
end
