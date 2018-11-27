class RunResult < LegResult

    field :mmile, as: :minute_mile, type: Float

    def calc_ave
        if event && secs
            miles = event.miles
            self.mmile = secs.nil? ? nil : (secs/60)/miles
        end
        #self.secs = 1.0 # dummiy float number
    end

end
