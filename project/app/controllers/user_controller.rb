class UserController < ApplicationController
    
    #controller for login form
    def login
		@stylesheet = "socialize"
		@title = "Login"
    end
    
    #handles the login info to sign a user in and create a session.
    def post_login
    	begin
	  @user = User.find_by_login!(params[:login]) #throws error if not found
	  if @user.password_valid?(params[:password])
    	 session[:userid] = @user.id
	     session[:username] = @user.login
	     redirect_to("/appts/view/#{@user.id}")
	  else
	     redirect_to(:action => :login, :alert => 'That is not a valid password')
	  end
	rescue ActiveRecord::RecordNotFound
	  redirect_to(:action => :login, :alert => 'That is not a valid login')
    	end
    end
    
    #resets the session when logout clicked, redirects to login page
    def logout
    	#reset_session
    	redirect_to(:action => :login)
    end

    #controller for form page
    def register
    	@stylesheet = "socialize"
        @title = "Register"

    end


    #checks if password fields equal, if the user already exists, and tries to create it
    #if successful, puts user in session and redirects to user page
    def post_register
    	if params[:password] != params[:password2]
	    	redirect_to(:action => :register, :alert => 'Your passwords do not match')
	    else
	    	begin
		    	if User.find_by_login(params[:login]) #throws error if not found
			    	redirect_to(:action => :register, :alert => 'That login already exists')
			    else
			    	#create a new user and try to save it   
			    	@user = User.new(:first_name => params[:first], :last_name => params[:last], :email => params[:email], :cal_id => params[:cal_id], :login => params[:login])
			    	@user.salt = rand(10000000)
			    	@user.password = Digest::SHA1.hexdigest("#{params[:password]}#{@user.salt}")
			    	if @user.save
				    	session[:userid] = @user.id
				    	session[:username] = @user.login
				    	redirect_to("/appts/view/#{@user.id}", :id => @user.id)
				    else
				    	redirect_to(:action => :register, :alert => 'That is not a valid login or name')
				    end
				end
			rescue ActiveRecord::RecordNotFound
				redirect_to(:action => :register, :alert => 'That is not a valid login or name')
			end
		end
    end
    
    
end
