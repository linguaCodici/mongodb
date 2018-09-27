class SwimResult < LegResult

    field :pace_100, type: Float #pace the swimmer could complete 100m

    def calc_ave
        if event && secs
            meters = event.meters
            self.pace_100 = secs.nil? ? nil : secs / ((meters) / 100)
        end
        #self.secs = 1.0 # dummiy float number
    end

end
