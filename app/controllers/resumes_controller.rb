class ResumesController < ApplicationController
  # GET /resumes
  # GET /resumes.json
  def index
    @resumes = Resume.all
    @user = current_user
    @relationships = Relationship.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resumes }
    end
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
    @resume = Resume.find(params[:id])

    send_data(@resume.data, :type => @resume.mime_type, :filename => "#{@resume.name}", :disposition => "inline")
  end

  # GET /resumes/new
  # GET /resumes/new.json
  def new
    @resume = Resume.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resume }
    end
  end

  # GET /resumes/1/edit
  def edit
    @resume = Resume.find(params[:id])
  end

  # POST /resumes
  # POST /resumes.json
  def create
    @user = current_user.id
    @resume = Resume.new do |t|
      if params[:resume][:name]
        t.name      = params[:resume][:name]
      end
      if params[:resume][:data]
        t.data      = params[:resume][:data].read
        t.filename  = params[:resume][:data].original_filename
        t.mime_type = params[:resume][:data].content_type
        t.user_id = @user
      end
    end

    # normal save
    if @resume.save
      redirect_to(resumes_url, :notice => 'Resume was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update
    @resume = Resume.find(params[:id])

    respond_to do |format|
      if @resume.update_attributes(:name =>       params[:resume][:name],
                                   :data =>       params[:resume][:data].read,
                                   :filename  =>  params[:resume][:data].original_filename,
                                   :mime_type =>  params[:resume][:data].content_type)
        format.html { redirect_to resumes_url, notice: 'Resume was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to resumes_url }
      format.json { head :no_content }
    end
  end
end