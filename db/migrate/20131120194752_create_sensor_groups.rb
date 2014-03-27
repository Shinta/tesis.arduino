class CreateSensorGroups < ActiveRecord::Migration
  def change
    create_table :sensor_groups do |t|

      t.timestamps
    end
  end
end
