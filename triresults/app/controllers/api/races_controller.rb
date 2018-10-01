module Api
    class RacesController < ApplicationController
        # global rescue for id not found 
        rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found

        # GET api/races
        # GET api/races.json
        def index
            render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
        end

        # GET api/races/1
        # GET api/races/1.json
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:id]}"
            elsif request.accept && request.accept != "*/*"
                # find the Race in the db
                race = Race.find(params[:id])
                render json: race, status: :ok
            else
            end
        end

        # POST api/races
        # POST api/races.json
        def create
            # when Accept is not specified or MIME type
            if !request.accept || request.accept == "*/*"
                render plain: "#{params[:race][:name]}", status: :ok
            elsif request.accept && request.accept != "*/*"
                # add a new Race to the db
                # Explicit hash arguments
                # name = params[:race][:name]
                # date = params[:race][:date]

                # Hash mass assignment
                # @race = Race.create(params[:race].to_hash.slice(:name, :date))

                # white-listed mass assignment
                race = Race.create(race_params)
                render plain: race.name, status: :created
            else
            end
        end

        # HEAD /api/races/1
        # HEAD /api/races/1.json
        def find
            if !request.accept || request.accept == "*/*"
                render plain: "#{params[:id]}"
            elsif request.accept && request.accept != "*/*"
                if params[:id].exists?
                    render plain: "", status: :ok
                else
                    render plain: "", status: 404
                end
            else
            end
        end

        # PATCH/PUT /api/races/1
        # PATCH/PUT /api/races/1.json
        def update
            Rails.logger.debug("method=#{request.method}")
            #replace the Race in the db with supplied values
            race = Race.find(params[:id])
            # # DEBUG: do not chain!! update returns true/false
            race.update(race_params)
            render json: race, status: :ok
        end

        # DELETE /api/races/1
        # DELETE /api/races/1.json
        def destroy
            race = Race.find(params[:id])
            race.destroy
            render nothing: true, status: :no_content
        end

        private

        def race_params
            params.require(:race).permit(:name, :date)
        end

        def record_not_found
            render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
        end
    end
end
