class ResponsesController < ApplicationController

  def new
    @survey = Survey.find(params[:survey_id])
    @response = @survey.responses.build
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @response = @survey.responses.build(response_params)
    if @response.save
      flash[:success] = "Success"
      redirect_to [:admin, :surveys]
    else
      puts "*" * 20
      p @response.errors
      p response_params
      flash[:error] = "Error"
      render :new
    end

  end

  private

  def response_params
    params.require(:response).permit(:answers_attributes => [:id, :question_id, :option_ids, {option_ids: []},  {:single_attributes => [:option_id]}, {:multis_attributes => [:option_id => []]}] )
  end



end
