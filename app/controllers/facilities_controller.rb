class FacilitiesController < InheritedResources::Base
  
  def index
    @facilities = Facility.all.order("created_at DESC")
  end

  def show
    @facility = Facility.find(params[:id])
    @statuses = Status.tagged_with(@facility.name).order("created_at DESC")
  end

  private

    def facility_params
      params.require(:facility).permit(:name)
    end
end

