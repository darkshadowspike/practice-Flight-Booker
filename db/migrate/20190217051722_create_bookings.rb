class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :flight ,index: true
      

      t.timestamps
    end
  end
end
