class User < ActiveRecord::Base
	has_many :appts
	
	#checks if the password is valid
      def password_valid?(candidate)
      	  if self.password == Digest::SHA1.hexdigest("#{candidate}#{self.salt}") and candidate != ""
	     return true
	  else
	     return false
	  end
      end
      
      #check validation
      validates_format_of :login, :with => /^\s*\S.*$/, :message=> "you must enter a login"
      validates_format_of :first_name, :with => /^\s*\S.*$/, :message=> "you must enter a first name"

end
