class Api::UsersController < ApplicationController
  def create
  	user = User.create_from_username({
  	  ripple_address: params.require(:ripple_address),
      username: params.require(:username),
      verification_code: params.require(:verification_code)
  	})
    if user.errors.messages.empty?
			if session[:language] && session[:language] == 'chinese'
				flash[:notice] = "欢迎注册 ComputingforGood.org. 我们每天都会计算一次你为 WCG 贡献的小时数，并发出 XRP，请在24小时内检查。记得参与计算哦。"
			else
				flash[:notice] = "Congratulations, you're now registered with ComputingforGood.org. We calculate your hours contributed and then pay out XRP daily, so please check back in 24 hours. In the meantime, compute away!"
		  end

      session[:user] = { member_id: user.member_id, username: user.username }
      render json: { user: user.attributes }
    else
      render json: { error: user.errors }
    end
  end
end
