class AssessmentsController < ApplicationController
  before_action :authenticate_user!, except: [:respond]
  before_action :set_assessment, only: [:show, :edit, :update, :destroy, :respond]
  before_action :access_control, except: [:respond]

  # GET /assessments
  # GET /assessments.json
  def index
    @assessments = Assessment.all
  end

  # GET /assessments/1
  # GET /assessments/1.json
  def show
  end

  # GET /assessments/new
  def new
    @assessment = Assessment.new
  end

  # GET /assessments/1/edit
  def edit
  end

  # POST /assessments
  # POST /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)
    @assessment.user = current_user

    respond_to do |format|
      if @assessment.save
        format.html { redirect_to @assessment, notice: 'Assessment was successfully created.' }
        format.json { render :show, status: :created, location: @assessment }
      else
        format.html { render :new }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assessments/1
  # PATCH/PUT /assessments/1.json
  def update
    respond_to do |format|
      if @assessment.update(assessment_params)
        format.html { redirect_to @assessment, notice: 'Assessment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assessment }
      else
        format.html { render :edit }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.json
  def destroy
    @assessment.destroy
    respond_to do |format|
      format.html { redirect_to assessments_url, notice: 'Assessment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /assessments/1/respond
  def respond
    @response = Response.new
    @response.assessment = @assessment
    @response.prepare_new_answers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      @assessment = Assessment.includes(:sections, :questions).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assessment_params
      params.require(:assessment).permit(:title, :subtitle, questions_attributes: [:id, :_destroy, :text, :more_info, :section_id, :type] )
    end

    def access_control
      if @assessment && (@assessment.user_id != current_user.id && !current_user.is_admin?)
        render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
        return false
      end
    end
end
