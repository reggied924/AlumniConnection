class WorkplacesController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy]
  #before_filter :correct_user?,   only: [:edit, :update]
  # GET /workplaces
  # GET /workplaces.json
  def index
    @workplaces = Workplace.all
    @relationships = Relationship.all
    @myWorkplaces = Array.new
    @followedWorkplaces = Array.new
    @mappedWorkplaces = Array.new

    @workplaces.each do |workplace|
      if workplace.user_id == current_user.id
        @myWorkplaces.push(workplace)
        @mappedWorkplaces.push(workplace)
      else 
        @relationships.each do |rel|
          if((current_user.id == rel.follower_id)&&(workplace.user_id == rel.followed_id))
            @followedWorkplaces.push(workplace)
            @mappedWorkplaces.push(workplace)

          end
        end
      end
    end
    
    #@json = @cities.to_gmaps4rails

    respond_to do |format|
      format.html { 
        if @workplaces != nil
          @json = @mappedWorkplaces.to_gmaps4rails do |workplace, marker|
          marker.infowindow render_to_string(:partial => "workplaces/infowindow", :locals => { :workplace => workplace })
          marker.title "#{workplace.company}"
          marker.json({:address => workplace.address})
          marker.picture({:picture => "assets/star-3.png", :width => 32, :height => 32 })
          end  
      end
      }# index.html.erb
      format.json { render json: @mappedWorkplaces }
    end
  end

  # GET /workplaces/1
  # GET /workplaces/1.json
  def show
    @workplace = Workplace.find_by_user_id(params[:id])
    if @workplace == nil
      @workplace = Workplace.find(params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workplace }
    end
  end

  # GET /workplaces/new
  # GET /workplaces/new.json
  def new
    @user = User.find(session[:user_id])
    @workplace = Workplace.find_by_user_id(@user.id)
    
    if !current_user?(@user)
      redirect_to workplace_path(@workplace)
    else
      if @workplace == nil
        @workplace = Workplace.new
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @workplace }
        end
      else
        redirect_to edit_workplace_path(@workplace.id)
      end
    end
  end


  # GET /workplaces/1/edit
  def edit
    @user = User.find(params[:id])
    @loggedUser = User.find(session[:user_id])
    @workplace = Workplace.find_by_user_id(session[:user_id])
    if @user.id == @loggedUser.id
      @user = User.find(session[:user_id])
      @workplace = Workplace.find_by_user_id(@user.id)
      if @workplace == nil
        @workplace = Workplace.new
      end  
    elsif @workplace == nil
      @workplace = Workplace.new
    else
      redirect_to workplace_path(@user)
    end
  end

  # POST /workplaces
  # POST /workplaces.json
  def create
    @user = User.find(session[:user_id])
    @workplace = Workplace.new(params[:workplace])
    @workplace.update_attributes(:user_id => @user.id, :user_email => @user.email)

    respond_to do |format|
      if @workplace.save
        format.html { redirect_to @workplace, notice: 'Workplace was successfully created.' }
        format.json { render json: @workplace, status: :created, location: @workplace }
      else
        format.html { render action: "new" }
        format.json { render json: @workplace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workplaces/1
  # PUT /workplaces/1.json
  def update
    @user = User.find(session[:user_id])
    @workplace = Workplace.find_by_user_id(@user.id)

    respond_to do |format|
      if @workplace.update_attributes(params[:workplace])
        format.html { redirect_to @workplace }
        flash[:success] = "Workplace was successfully updated."
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workplace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workplaces/1
  # DELETE /workplaces/1.json
  def destroy
    @user = User.find(session[:user_id])
    @workplace = Workplace.find_by_user_id(@user.id)
    @workplace.destroy

    respond_to do |format|
      format.html { redirect_to workplaces_url }
      format.json { head :no_content }
    end
  end
  
  private
  def correct_user?(userpage)
      @user = User.find(session[:user_id])
      @userpage = userpage
      if @userpage.id == @user.id
        return true
      end
      return false
    end
end
