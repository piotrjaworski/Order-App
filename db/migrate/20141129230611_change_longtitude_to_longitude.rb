class ChangeLongtitudeToLongitude < ActiveRecord::Migration
  def change
    rename_column :restaurants, :longtitude, :longitude
  end
end
