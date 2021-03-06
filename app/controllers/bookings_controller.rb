class BookingsController < ApplicationController
	def new
		@flight = Flight.find(params[:flight_id])
		@booking = Booking.new
        @passengers =[]
		params[:passengers].to_i.times do
			@booking.passengers.build		
		end
	end

	def create
		@booking = Booking.new(booking_params)
		if @booking.save
			@booking.passengers.each do |p|
				PassengerMailer.with(user: p).thanking_email.deliver_now
			end
			redirect_to @booking
        else
           redirect_to new_booking_url
		end
	end

	def show 
		@booking = Booking.find(params[:id])
	end

	private 

	def booking_params
		params.require(:booking).permit(:flight_id, :passenger_id, passengers_attributes:[:name, :email])
	end
end
