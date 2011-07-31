# encoding: UTF-8
require 'spec_helper'

describe Place do
  def params
    { name: '東京都庁', address: '東京都新宿区西新宿２丁目８−１', latitude: 35.6891848, longitude: 139.69164810000007 }
  end
  
  context '正常に保存された場合' do
    before do
      @place = Place.new params
      @place.save!
    end
    
    after do
      @place.destroy
    end
  
    it { @place.should_not be_new_record }
    it { @place.name.should == params[:name]}
    it { @place.address.should == params[:address]}
    it { @place.latitude.should == params[:latitude] }
    it { @place.longitude.should == params[:longitude] }
    
    it 'coordinatesはMongoDB仕様（GeoJSON spec仕様）に従っているため、経度、緯度の順になる' do
      @place.coordinates.should == [ params[:longitude], params[:latitude] ]
    end
    
    it 'nearクエリ（mongoで実行されるのは$nearSphere）は緯度、経度の順で指定する' do
      places = Place.near([ params[:latitude], params[:longitude] ], 0.00002).to_a
      places.should be_include(@place)
    end
  end
  
  context 'validationに違反した場合' do
    before do
      @before_count = Place.count
    end
    
    it 'addressが指定されていない' do
      place = Place.new(name: '東京スカイツリー')
      place.save.should be_false
      Place.count.should == @before_count
    end
    
    it 'nameが指定されていない' do
      place = Place.new(address: '東京都墨田区')
      place.save.should be_false
      Place.count.should == @before_count
    end
  end
end
