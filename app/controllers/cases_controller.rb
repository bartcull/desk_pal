class CasesController < ApplicationController

  def index
    filter = Filter.new
    @first_filter_name = filter.first_filter_name
    @cases = Case.all(filter.first_filter_cases_endpoint)
    @entities = @cases["_embedded"]["entries"]
  end

  def update_label
    respond_to do |format|
      if Case.update_first_case(case_params[:label_name])
        format.html { redirect_to cases_path, notice: 'Case was successfully updated.' }
      else
        format.html { redirect_to cases_path, alert: 'Something went horribly wrong!' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.permit(:label_name)
    end
end
