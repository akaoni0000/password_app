class UsersController < ApplicationController

    def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            flash[:notice] = "ログインに成功しました"
            session[:user_id] = @user.id
            redirect_to users_path
        else
            flash[:notice] = "メールアドレスまたはパスワードが違います"
            redirect_to root_path
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました"
        @current_user = nil
        redirect_root
    end

    def new
        if @current_user
            redirect_to users_path
        else 
            @user = User.new
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "ユーザー情報を登録しました"
            redirect_to users_path
        else
            redirect_to new_user_path
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "ユーザー情報を更新しました"
            redirect_to users_path
        else
            redirect_to user_path(params[:id])
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "ユーザー情報を削除しました"
        redirect_to users_path
    end

    def index
        @users = User.all
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
