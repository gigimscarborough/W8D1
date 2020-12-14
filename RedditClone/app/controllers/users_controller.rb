class UsersController < ApplicationController

    before_action :ensure_logged_in, only: [:index, :show]
    def new
        @user = User.new

        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            redirect_to users_url
        else
            flash.now[:errors] = ['Invalid username or password']
            render :new
        end
    end

    def index
        @users = User.all

        render :index
    end

    def show
        @user = User.find(params[:id])

        render :show
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
