# -*- coding: utf-8 -*-
class Place
  include Mongoid::Document
  include Geo::Geocodable
  
  field :name, type: String, label: '名前'
  
  validates_presence_of :name, :address
end
