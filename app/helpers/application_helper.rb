module ApplicationHelper
    def login_user user
        session[:user_id]=user.id
    end
    def current_user       
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id=cookies.signed[:user_id])
            user=User.find_by id:user_id
            if user&.authenticate?(cookies[:remember_token])
                @current_user = user
            end
            
        end       
    end
    def remember user
        user.remember
        cookies.permanent[:remember_token] = @user.remember_token
        cookies.permanent.signed[:user_id] = @user.id
    end
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
       
    def login?
        return if current_user
       
         redirect_to login_path
         flash[:danger] = "u need login"
      
     end
    
end
