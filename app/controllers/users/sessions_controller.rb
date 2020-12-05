class Users::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]

  protected

  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
        flash[:error] = "お客様は退会済みです。お手数ですが、別のメールアドレスで再度ご登録ください。"
        redirect_to new_user_session_path
      end
    else
      flash[:error] = "※メールアドレスとパスワードが一致しません。"
    end
  end
end
