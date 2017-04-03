class Admin::SurveysController < ApplicationController
  def new
    @survey = Survey.new
  end

  def index
    @surveys = Survey.all
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      flash[:success] = "Success! Your survey '#{@survey.title}' has been created!"
      redirect_to [:admin, @survey]
    else
      flash[:error] = "Oops! Please check your form for errors"
      render :new
    end
  end

  def show
    session[:question_params] = session[:form_step] = nil
    @survey = Survey.find(params[:id])
    @questions = @survey.questions
  end

  def questiontype
    @survey = Survey.find(params[:id])
    if valid_qtype?
      session[:qtype] = params['qtype']
      return redirect_to [:new, :admin, @survey, :question]
    else
      render :show
    end
  end

  def results
    @survey = Survey.find(params[:id])
  end

  private

  def survey_params
    params.require(:survey).permit(:title, :description)
  end

  def valid_qtype?
    params['qtype'] == 'Option' || params['qtype'] == 'Num'
  end
end
