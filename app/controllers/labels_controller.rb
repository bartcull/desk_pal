class LabelsController < ApplicationController
  def index
    @labels = Label.all_enabled
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)

    if @label.save
      redirect_to @label, notice: 'Label was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    Label.destroy(params[:id])
    redirect_to labels_url, notice: 'Label was successfully disabled.'
  end

  private
    def label_params
      params.require(:label).permit(:name, :description, :color, types: [])
    end
end
