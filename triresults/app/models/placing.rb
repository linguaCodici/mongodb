class Placing
    # custom type Placing, processing placing format
    attr_accessor :name, :place


    def initialize(name, place)
        @name = name #String
        @place = place #Integer
    end

    # @return a Ruby hash in MongoDB format
    def mongoize
        return {:name => @name,
            :place=> @place}
    end

    # @param a input in 3 forms: nil, class instance, db hash
    # @return nil or a ruby hash
    def self.mongoize input
        case input
        when Placing then input.mongoize
        else
            input
        end
    end

    # @param a input in 3 forms: nil, class instance, db hash
    # @return nil or a class instance
    def self.demongoize input
        case input
        # when nil then nil
        when Hash then
            Placing.new(input[:name], input[:place])
        # when Point then input
        else
            input
        end
    end

    def self.evolve input
        case input
        when Placing then input.mongoize
        else
            input
        end
    end
end
