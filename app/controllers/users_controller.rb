class UsersController < ApplicationController
    def show
        @user = User.find_by id: params[:id]
        unless @user
        flash[:error] = "User not found."
        redirect_to root_path and return
    end
  end
    def new
      @user = User.new
    end
        def create
            @user = User.new(user_params)
            #byebug
            if @user.save
              # do something
              log_in @user
              flash[:success] = "User created successufully!"
              redirect_to @user
            else
              render :new
            end
          end
          private
            def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthday, :gender)
          end
end
