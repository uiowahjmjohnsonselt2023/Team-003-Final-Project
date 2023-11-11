# verification_controller.rb
class VerificationController < ApplicationController
    def verify
      @user = User.find_by(verification_token: params[:token])
  
      if @user && !@user.verification_status
        # If the user exists and is not yet verified
        @user.update(verification_status: true, verification_token: nil)
        # You may want to log the user in automatically here or redirect to the login page
        flash[:success] = 'Your account has been verified. You can now log in.'
        redirect_to login_path
      else
        #Redirect if already Verified
        flash[:error] = 'Invalid verification link or account already verified.'
        redirect_to root_path
      end
    end
  end
  