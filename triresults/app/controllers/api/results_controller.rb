module Api
    class ResultsController < ApplicationController

        # before_action :set_result, only: [:show, :update]
        # before_action :set_race, only: [:index]
        # rescue_from Mongoid::Errors::DocumentNotFound, with: :id_not_found

        # GET /api/races/:race_id/results
        # GET /api/races/:race_id/results.json
        def index
            if !request.accept || request.accept == "*/*"
                # p "hi"
                render plain: "/api/races/#{params[:race_id]}/results"
            else
                # p "oh no"
                # @entrants = @race.entrants
                # fresh_when
                set_race
                @entrants = @race.entrants
                if stale? last_modified: @entrants.max(:updated_at)
                    render :index, status: :ok
                end
                # fresh_when last_modified: @entrants.max(:updated_at)
            end
        end

        # GET /api/races/:race_id/results/1
        # GET /api/races/:race_id/results/1.json
        def show
            Rails.logger.debug {"found result #{@result}"}
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
            else
                set_result
                fresh_when(@result)
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
            # byebug
            # result_params = params[:result]
            # if result_params
            #     result_params.each do |key, value|
            #         Rails.logger.debug {"#{key} and #{value}"} #hash
            #         # DEBUG: total not getting updated
            #         @result["#{key}"] = @result.race.race["#{key}"]
            #         @result["#{key}_secs"] = value.to_f
            #     end
            #     @result.save
            #     Rails.logger.debug {"#{@result.attributes} and current total #{@result.secs}"}
            #
            # end

            # DEBUG: this fails because of $pushall
            set_result
            result_params = params[:result]
            # ["swim", "t1", "bike", "t2", "run"].ea
            if result_params
              if result_params[:swim]
                @result.swim=@result.race.race.swim
                @result.swim_secs = result_params[:swim].to_f
              end
              if result_params[:t1]
                @result.t1=@result.race.race.t1
                @result.t1_secs = result_params[:t1].to_f
              end
              if result_params[:bike]
                @result.bike=@result.race.race.bike
                @result.bike_secs = result_params[:bike].to_f
              end
              if result_params[:t2]
                @result.t2=@result.race.race.t2
                @result.t2_secs = result_params[:t2].to_f
              end
              if result_params[:run]
                @result.run=@result.race.race.run
                @result.run_secs = result_params[:run].to_f
              end
              # Rails.logger.debug {"#{@result.secs}"}
              # fresh_when(@result)

            end
            @result.save
            render nothing: true, status: :ok
        end

        private

        def set_race
            @race = Race.find(params[:race_id])
        end

        def set_result
            @result = Race.find(params[:race_id]).
                entrants.where(:id => params[:id]).first
        end

        # def id_not_found
        #     if !request.accept || request.accept == "*/*"
        #         render plain: "woops: cannot find race[#{params[:race_id]}] result[#{params[:id]}]",
        #             status: :not_found
        #     else
        #         respond_to do |format|
        #             format.json {render template: "api/error_msg.json.jbuilder", status: :not_found,
        #                 locals: { :msg => "woops: cannot find race[#{params[:race_id]}] result[#{params[:id]}]"}}
        #             format.xml {render template: "api/error_msg.xml.builder", status: :not_found,
        #                 locals: { :msg => "woops: cannot find racerace[#{params[:race_id]}] result[#{params[:id]}]"}}
        #         end
        #     end
        # end
    end
end
