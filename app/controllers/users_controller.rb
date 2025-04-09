class UsersController < ApplicationController
          before_action :logged_in_user, only:[:edit, :update]
          before_action :correct_user, only: [:edit, :update]
          before_action :find_user, only: [:edit, :update, :following, :followers]
          before_action :correct_user, only: [:edit, :update]

          def index
            @pagy, @users = pagy(User.order(:name), items: 10)
          end

          def show
            @user = User.find_by(id: params[:id])
            if @user.nil?
              flash[:error] = "User not found."
              redirect_to root_path
            else
              @pagy, @microposts = pagy(@user.feed.order(created_at: :desc), items: 5)
              @micropost = current_user.microposts.build if logged_in? && current_user == @user
            end
          end

            def new
              @user = User.new
            end

            def create
                  @user = User.new(user_params)
                  if @user.save
                    @user.send_activation_email
                    flash[:info] = "Please check your email to activate your account."
                    redirect_to root_url, status: :see_other
              else
                render :new
            end
          end

          def edit
            @user = User.find_by id: params[:id]
            return if @user

            flash[:warning] = "Not found users!"
            redirect_to root_path
          end

          def update
            @user = User.find_by id: params[:id]
            if @user.update user_params
              flash[:success] = "Profile updated successfully!"
              redirect_to @user
              else
                puts @user.errors.full_messages
                render :edit
              end
            end

            def destroy
              @user = User.find_by(id: params[:id])
              if @user
                @user.destroy
                flash[:success] = "User deleted"
                respond_to do |format|
                  format.html { redirect_to users_path }
                  format.turbo_stream
                end
              else
                flash[:error] = "User not found"
                redirect_to users_path
              end
            end
            def following
              @title = "Following"
              @pagy, @users = pagy @user.following, items: 10
              render :show_follow
            end
            def followers
              @title = "Followers"
              @pagy, @users =pagy @user.followers, items: 10
              render :show_follow
            end
          private

            def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthday, :gender)
          end

          def find_user
            @user = User.find_by(id: params[:id])
            redirect_to root_path unless @user
          end

          def logged_in_user
            unless logged_in?
              flash[:danger] = "please log in"
              store_location
              redirect_to login_url
            end
          end

          def correct_user
            return if current_user?(@user) 
            flash[:error] = "You cannot edit this account"
            redirect_to root_url
          end
          def admin_user
            redirect_to root_path unless current_user.admin?
          end
end
