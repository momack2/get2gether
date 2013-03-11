class ApptsController < ApplicationController

    def user
      	@appts = []
		if (params[:id])
		     @id = params[:id]
			 begin
			  	@curr = User.find(@id) #throws error if not found
				for appt in @curr.appts() do
				  	#meeting = {:id => appt.id, :start_time => appt.start_time, :end_time => appt.end_time, :event_name => appt.event_name, :booker_name => appt.booker_name} 
				   	@appts << appt
				end
				@title = @curr.first_name
		     rescue ActiveRecord::RecordNotFound
			    @title = "That user doesn't exist..."
			 end
		 else
		 	@title = "Please choose a user..."
	     end
	     @stylesheet = "socialize"
	 end
	 
	 def post_user
	 
	 
	 end
	 
	 def book
	 	if (params[:id] and params[:appt_id])
    		begin
	    		@appt = Appt.find(params[:appt_id]) #throws error if not found
	    		@curr = User.find(params[:id]) #throws error if not found
	    	rescue ActiveRecord::RecordNotFound
				redirect_to(:action => :user, :alert => 'Please choose an appointment')
			end
		else
			redirect_to(:action => :user, :alert => 'Please choose an appointment')
		end

	 end
	 
	 def post_book
	 	if (params[:id])
    		begin
	    		@appt = Appt.find(params[:id]) #throws error if not found
	    		@appt.booker_name = params[:booker]
	    		@appt.booker_message = params[:message]
	    		@appt.booked = true
	    		@user = User.find(@appt.user_id) #throws error if not found
	    		
	    		if @appt.save
	    			if @user.cal_id
	    			#	result = client.execute(:api_method => service.events.quick_add, :parameters => {'calendarId' => @appt.user().cal_id, 'text' => @appt.event_name + ' from ' + @appt.start + ' to ' + @appt.end + ' with ' @appt.booker})
	    			#	print result.data.id
                    end
                    if (@user.email)
                    	UserMailer.appt_email(@user, @appt).deliver
                    end
                    if (@user.phone)
                    	#use twilio to text message!
                    end	
                    
                         
			    	redirect_to("/user/index.html", :alert => "Thanks, #{@appt.booker_name}! You successfully planned a get2gether with #{@user.first_name}!")
			    else
			    	redirect_to(:action => :appt, :alert => 'That is not a valid appointment')
			    end
			rescue ActiveRecord::RecordNotFound
				redirect_to(:action => :appt, :alert => 'Please choose an appointment')
			end
		else
			redirect_to(:action => :user, :alert => 'Please choose an appointment')
		end
	 end
	 
	 def view
      	  @appts = []
		  if (params[:id])
		     @id = params[:id]
			 begin
			  	@curr = User.find(@id) #throws error if not found
			  	for appt in @curr.appts() do
			    	#meeting = {:id => appt.id, :start_time => appt.start_time, :end_time => appt.end_time, :event_name => appt.event_name, :booker_name => appt.booker_name} 
			     	@appts << appt
			 	end
				@title = @curr.first_name
		     rescue ActiveRecord::RecordNotFound
			    @title = "DNE"
			 end
		  else
		 	@title = "Oops!"
	      end
	      @stylesheet = "socialize"
	 end
	 
	 def appt
	 	@stylesheet = "socialize"
        @title = "New Appointment"
	 end
	 
	 #if successful, creates new appointment and redirects
	 def post_appt
	 	if (session[:userid])
    		begin
	    		@user = User.find(session[:userid]) #throws error if not found
	    		@appt = Appt.new(:user_id => session[:userid], :other => params[:date], :start_time => params[:start], :end_time => params[:end], :description => params[:description], :event_name => params[:event_name], :booked => false)
	    		if @appt.save
			    	redirect_to("/appts/view/#{@user.id}", :id => @user.id)
			    else
			    	redirect_to(:action => :appt, :alert => 'That is not a valid appointment')
			    end
			rescue ActiveRecord::RecordNotFound
				redirect_to(:action => :appt, :alert => 'Please log in to create appointments')
			end
		else
			redirect_to(:action => :appt, :alert => 'Please login to create appointments')
		end
	 end
	 
end