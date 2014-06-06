class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :department_status, :display_demand_status, :demand_on_hold, :book_returned_to_library_or_damaged?, :book_demand_to_bring_back?, :book_demand_taken?, :book_demand_unavailable?, :agc_book_demand_left_or_unavailable?, :display_demand_book_status, :book_demand_on_hold, :book_demand_validated_or_left?
  #prepend_before_filter :authenticate_user!, :cache_buster
  
  private 
    
		def not_a_number?(n)
    	n.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? true : false 
	  end
	  
	  def valid_email?(str)
	    str.to_s.match(/^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i) == nil ? false : true
	  end
	  
	  def capitalization(raw_string)
    	@string_capitalized = ''
    	raw_string.split.each do |name|
    		@string_capitalized << "#{name.capitalize} "
    	end
    	@string_capitalized.strip
    end
    
# Vider le cache des navigateurs	
	  def cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
    
    def layout_used 
    	if current_user.blank?
    	  "sessions"
    	else
			  case current_user.short_profile
		      when "ADMIN"
			      "administrator"
		      when "LV1"
			      "lvs"
		      when "LV2"
			      "lvs"
		      when "CD"
			      "cd"
		      when "CD-BD"
			      "cd_bd"
		      when "CSADP-BD"
			      "csadp_bd"
		      when "AGC"
		        "agc"
		      when "PE"
		        "pe"
			    else
			      "sessions"
		      end
		  end			
    end 
	  
end
