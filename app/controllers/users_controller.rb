class UsersController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  skip_before_filter :verify_authenticity_token 

  def index
    @users = User.paginate(page: params[:page], order: 'name ASC', per_page: 10)
      
      respond_to do |format|
        format.html
        format.json{ render json: @users }
      end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
      
    respond_to do |format|
      format.html
      format.json { render json: @microposts }
    end
      
  end

  def new
    @user = User.new
    
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(params[:user])
      
    respond_to do |format|
      if @user.save
            sign_in @user
            flash[:success] = "Welcome to Alumni Connection!"
            UserMailer.welcome_email(@user).deliver
            format.html { redirect_to @user }
            format.json { render json: @user, status: :created, location: @user } 
          else
            format.html { render action: "new"}
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
      respond_to do |format|
        if @user.update_attributes(params[:user])
              flash[:success] = "Profile Updated"
              sign_in @user
              format.html { redirect_to @user }
              format.json { head :no_content } 
            else
              format.html { render action: "edit"}
              format.json { render json @user.errors, status: :unprocessable_entity  }
            end
      end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Successfully Deleted"
    respond_to do |format|
      format.html { redirect_to users_url } 
      format.json { head :no_content }
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def workplace
    @user = User.find(params[:id])
    @workplace = Workplace.find_by_user_email(@user.email)
    if !current_user?(@user)
      if @workplace == nil
        render 'no_workplace'
      else
        render 'workplace'
      end
    else 
      if @workplace == nil
        @workplace = Workplace.new
      end
      respond_to do |format|
        format.html{ render 'workplaces/edit' }
        format.json{ render json: @workplace }
      end
      
    end
  end
  
  def makeAdmin
    @user = User.find(params[:id])
      if @user.update_attribute(:admin, @user.admin = true)
        redirect_to current_user
        flash[:success] = @user.name + " has been made an Administrator"
        
      else
        render current_user
        flash[:success] = "User unable to be updated"
      end
  end
  
  def removeAdmin
    @user = User.find(params[:id])
         if @user.update_attribute(:admin, @user.admin = false)
           redirect_to current_user
           flash[:success] = "Administrator " + @user.name + " removed"
           
         else
           render current_user
           flash[:success] = "User unable to be updated"
         end
  end
  
  def addFaculty
      @user = User.find(params[:id])
        if @user.update_attribute(:faculty, @user.faculty = true)
          redirect_to current_user
          flash[:success] = @user.name + " has been made a Faculty member"
          
        else
          render current_user
          flash[:success] = "User unable to be updated"
        end
    end
    
  def removeFaculty
      @user = User.find(params[:id])
           if @user.update_attribute(:faculty, @user.faculty = false)
             redirect_to current_user
             flash[:success] = @user.name + " has been removed from Faculty"
             
           else
             render current_user
             flash[:success] = "User unable to be updated"
           end
    end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
