class VerificationController < ApplicationController
  def verify
    @user = User.find_by(verification_token: params[:token])

    if @user && !@user.verified
      @user.update(verified: true, verification_token: nil)
      flash[:success] = 'Your account has been verified. You can now log in.'
      redirect_to login_path
    else
      flash[:error] = 'Invalid verification link or account already verified.'
      redirect_to root_path
    end
  end
end
