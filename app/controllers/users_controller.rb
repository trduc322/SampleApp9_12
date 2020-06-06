class UsersController < ApplicationController
    before_action :login?, only: %i(show edit update)
    before_action :load_user, only: %i(show edit update destroy)
    before_action :correct_user?, only: %i( edit update)
    before_action :valid_admin?, only: %i( destroy)
    def show       
    end


    def index
     @users = User.paginate(page: params[:page])  
    end
    def destroy
        if @user.destroy
            flash[:success] = "delete success"            
        else
            flash[:success] = "delete fail"            
        end
        redirect_to users_path
    end   
    
    def update
        if @user.update user_params
            flash[:success] = "update success"
            redirect_to @user
        else
            flash[:danger] = "update fail"
            render :edit
        end 
    end
    def  new
        @user= User.new
    end
    def  edit
     
     end
    def create
        @user = User.new user_params      
        if @user.save
            flash[:success] = "create account successful"
            redirect_to @user
        else
            flash.now[:danger] = "create account failse"
            render :new #symbol
        end
    end
    private
    def user_params
        params.require(:user).permit :name, :email, :password, :password_confirmation
    end
    def load_user
        @user= User.find_by id: params[:id]  
        unless @user
            flash[:danger] = " not found user id: #{params[:id]}"
            redirect_to root_path
            
    end
    def correct_user?
        if current_user != @user
            flash[:danger] = "Access denied"
            redirect_to root_path
        end
    end
    def valid_admin?
        unless current_user.is_admin
        flash[:danger] = "Access denied"
        redirect_to user_path
        
    end
    
end 
end
