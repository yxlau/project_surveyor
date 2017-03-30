class Admin::QuestionsController < ApplicationController

  def new
    session[:question_params] ||= {}
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.build(session[:question_params])
    @question.current_step = session[:form_step]
  end

  def create
    merge_params
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.build(question_params)
    @question.current_step = session[:form_step]
    @question.option_count.times { @question.options.build } if @question.options.empty? && @question.option_count

    if params[:back]
      session[:question_params].delete('options_attributes')
      @question.current_step = @question.back
    elsif @question.valid?
      if @question.last_step?
        @question.save if @question.all_valid?
      else
        @question.current_step = @question.next_step
      end
    elsif !@question.valid?
      flash[:error] = "Alert, alert! Better take another look at that form."
    end

    session[:form_step] = @question.current_step

    if @question.new_record?

      render :new
    else
      session[:form_step] = session[:question_params] = nil
      flash[:success] = "Success! A question is born."
      redirect_to [:admin, @survey]
    end

  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:success] = "Success! Your question has been removed. Pew pew pew!"
    else
      flash[:error] = "Sorry! That question is indestructible."
    end
    redirect_to [:admin, @question.survey]
  end

  private
  def question_params
    params.require(:question).permit(:option_count, :multi, :title, :required, {options_attributes: [:id, :value, :question_id]})
  end

  def merge_params
    session[:question_params].deep_merge!(params[:question]) if params[:question]
    params[:question] = ActionController::Parameters.new(session[:question_params]).merge(params[:question])
  end


end
