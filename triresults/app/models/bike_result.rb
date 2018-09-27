class BikeResult < LegResult

    field :mph, type: Float

    def calc_ave
        if event && secs
            miles = event.miles
            self.mph = secs.nil? ? nil : miles*3600/secs
        end
        ## dummiy float number
    end

end
