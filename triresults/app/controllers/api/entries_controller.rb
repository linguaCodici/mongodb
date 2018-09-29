module Api
    class EntriesController < ApplicationController
        def index
            render plain: "/api/racers/#{params[:racer_id]}/entries"
        end
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
            else
            end
        end
    end
end
