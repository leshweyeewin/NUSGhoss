class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy, :add_to_favourities, :remove_from_favourities, :report]
  before_action :authenticate_user!, except: [:index, :show, :tagged]
  before_action :find_tagged_statuses, only: [:tagged]
  # GET /statuses
  # GET /statuses.json
  def index
    @q = Status.ransack(params[:q])
    @statuses = @q.result(distinct:true).includes(:tags).order("created_at DESC")
    @statuses = Status.paginate(:page => params[:page], :per_page => 10);
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @user_comment = UserComment.new(:status_id => @status.id)
    if user_signed_in?
      if @status.tags.any?
        @status.tags.each do |tag|
          if current_user.first_name == tag.name || current_user.last_name == tag.name || current_user.profile_name == tag.name
            @tagged_statuses = true
          end
        end
      end
    end
  end

  # GET /statuses/new
  def new
    @status = current_user.statuses.build
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = current_user.statuses.build(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to statuses_url, notice: 'Status was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { render :show, status: :ok, location: @status }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def tagged
      @tag = ActsAsTaggableOn::Tag.find_by_name(params[:tag])
      unless @user
        @statuses = Status.tagged_with(params[:tag]).order("created_at DESC")
      end
  end

  def add_to_favourities
    @status.liked_by current_user
    redirect_to @status
  end

  def remove_from_favourities
    @status.unliked_by current_user
    redirect_to @status
  end

  def report
    @status.update_attributes :reported => !@status.reported
    redirect_to @status, notice: 'You have reported this status of having abusive content.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    def find_tagged_statuses
      @user = User.search(params[:tag])
      if @user
        @statuses = Status.tagged_with(@user.first_name).order("created_at DESC")
        unless @user.first_name == @user.last_name
          @statuses += Status.tagged_with(@user.last_name).order("created_at DESC")
        end
        unless @user.first_name == @user.profile_name || @user.last_name == @user.profile_name
          @statuses += Status.tagged_with(@user.profile_name).order("created_at DESC")
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:user_id, :content, :reported, :tag_list)
    end
end
