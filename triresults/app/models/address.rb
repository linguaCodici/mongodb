class Address
    # custom type Address, processing the address format with JSON data
    attr_accessor :city, :state, :location

    # # DEBUG: this part raises error
    # include Mongoid::Document
    # field :city, type: String
    # field :state, type: String
    # field :location, as: :loc, type: Point

    # def initialize
    #     @city = nil
    #     @state = nil
    #     @location = nil
    # end

    def initialize(city=nil, state=nil, location=nil)
        @city = city
        @state = state
        # DEBUG: cannot pass in location directly
        # need to instantiate a new Point
        # UPDATE: fixed with demongoize
        @location = Point.demongoize(location)
    end

    # @return a Ruby hash in MongoDB format
    def mongoize
        return {:city => @city,
            :state=> @state,
            :loc => Point.mongoize(@location)} # need to be :loc in document
    end

    # @param a input in 3 forms: nil, class instance, db hash
    # @return nil or a ruby hash
    def self.mongoize input
        case input
        when Address then input.mongoize
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
            if input[:loc]
                Address.new(input[:city], input[:state], input[:loc])
            else
                Address.new(input[:city], input[:state], input[:location])
            end
        # when Point then input
        else
            input
        end
    end

    def self.evolve input
        case input
        when Address then input.mongoize
        else
            input
        end
    end
end
