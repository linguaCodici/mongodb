class Point
# custom type Point; do not have on ID
    attr_accessor :longitude, :latitude

    def initialize(lng, lat)
        @longitude = lng
        @latitude = lat
    end

    # @return a Ruby hash in MongoDB format
    def mongoize
        return {:type => "Point",
             :coordinates => [@longitude, @latitude]}
    end

    # @param a input in 3 forms: nil, class instance, db hash
    # @return nil or a ruby hash
    def self.mongoize input
        case input
        when nil then nil # not necessary
        when Hash then #input # ? need to uniform the hash or no
            if input[:type] #if not nil, then it's in GeoJSON Point format
                Point.new(input[:coordinates][0], input[:coordinates][1])
                    .mongoize
            else       #in legacy format
                Point.new(input[:lng], input[:lat]).mongoize
            end
        when Point then input.mongoize
        end
    end

    # @param a input in 3 forms: nil, class instance, db hash
    # @return nil or a class instance
    def self.demongoize input
        case input
        when nil then nil
        when Hash then
            Point.new(input[:coordinates][0], input[:coordinates][1])
        when Point then input
        end
    end

    # same as mongoize class method
    def self.evolve input
        case input
        when nil then nil # not necessary
        when Hash then #input # ? need to uniform the hash or no
            if input[:type] #if not nil, then it's in GeoJSON Point format
                Point.new(input[:coordinates][0], input[:coordinates][1])
                    .mongoize
            else       #in legacy format
                Point.new(input[:lng], input[:lat]).mongoize
            end
        when Point then input.mongoize
        end
    end
end
