# -*- encoding: UTF-8 -*-
module Geo
  module Geocodable  
    def self.included(model)
      model.class_eval do 
        include Mongoid::Document
        include Geocoder::Model::Mongoid
        
        field :address, type: String, label: "住所"
        field :coordinates, type: Array, default: []

        index [[ :coordinates, Mongo::GEO2D ]], min: -180, max: 180, background: true
        geocoded_by :address
      end
    end

    def latitude
      self.coordinates[1]
    end

    def latitude=(lat)
      self.coordinates[1] = lat.to_f
    end

    def longitude
      self.coordinates[0]
    end

    def longitude=(long)
      self.coordinates[0] = long.to_f
    end
  end
end

