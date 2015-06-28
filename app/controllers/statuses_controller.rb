class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :tagged]

  # GET /statuses
  # GET /statuses.json
  def index
    @q = Status.ransack(params[:q])
    @statuses = @q.result(distinct:true).includes(:tags).order("created_at DESC")
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @user_comment = UserComment.new(:status_id => @status.id)
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
      @statuses = Status.tagged_with(params[:tag])
      @tag = ActsAsTaggableOn::Tag.find_by_name(params[:tag])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:user_id, :content, :tag_list)
    end
end
