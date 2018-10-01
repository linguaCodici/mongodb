module Api
    class ResultsController < ApplicationController

        before_action :set_result, only: [:show, :update]
        rescue_from Mongoid::Errors::DocumentNotFound, with: :id_not_found

        # GET /api/races/:race_id/results
        # GET /api/races/:race_id/results.json
        def index
            render plain: "/api/races/#{params[:race_id]}/results"
        end

        # GET /api/races/:race_id/results/1
        # GET /api/races/:race_id/results/1.json
        def show
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

        # PATCH /api/races/1/results/1
        # PATCH /api/races/1/results/1.json
        def update


        end

        private

        def set_result
            @result = Race.find(params[:race_id]).
                entrants.where(:id => params[:id]).first
        end

        def id_not_found
            if !request.accept || request.accept == "*/*"
                render plain: "woops: cannot find race[#{params[:race_id]}] result[#{params[:id]}]", status: :not_found
            else
                respond_to do |format|
                    format.json {render template: "api/error_msg.json.jbuilder", status: :not_found,
                        locals: { :msg => "woops: cannot find race[#{params[:race_id]}] result[#{params[:id]}]"}}
                    format.xml {render template: "api/error_msg.xml.builder", status: :not_found,
                        locals: { :msg => "woops: cannot find racerace[#{params[:race_id]}] result[#{params[:id]}]"}}
                end
            end
        end
    end
end
