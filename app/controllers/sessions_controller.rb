class SessionsController < ApplicationController
        def new
        #byebug 
        # Cookie thong thuong
        cookies[:demo_normal] = "normal"

        # Gia tri cua cookie se duoc ma hoa
        # Cookie nay duoc ma hoa voi key la "secret.secret_key_base"
        cookies.signed[:demo_signed] = "signed"

        # Gia tri cua cookie se duoc ma hoa tuong tu nhu cookies.signed
        # Cookie nay duoc ma hoa voi key la "secret.secret_key_base"
        cookies.encrypted[:demo_encrypted] = "encrypted"

        # Khi dung httponly, cookie se khong the doc duoc bang JavaScript,
        # va cookie se het han sau thoi gian
        cookies[:demo_httponly] = {value: "http only", expires: Time.current + 1.hour, httponly: true }
        Rails.logger.info "Đã set cookie demo_httponly với HttpOnly"
        # Phần code khác...
        # Khi dung cookies.permanent, cookie nay se het han sau mot thoi gian rat dai, khoang 20 nam tu thoi
        cookies.permanent[:demo_permanent] = "permanent"
      end

      def create
        user = User.find_by(email: params.dig(:session, :email)&.downcase)
        if user && user.authenticate(params.dig(:session, :password))
          if user.activated?
            forwarding_url = session[:forwarding_url]
            reset_session
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            log_in user
            redirect_to forwarding_url || user
            else
              flash[:warning] = "Account not activated. Check your email for the activationlink."
              redirect_to root_url, status: :see_other
            end

        else
          flash.now[:danger] = t "invalid_email_password_combination"
          render :new, status: :unprocessable_entity
         end
      end

      def destroy
        log_out 
        redirect_to root_path
      end
    end
