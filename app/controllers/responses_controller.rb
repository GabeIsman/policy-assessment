class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]
  before_action :access_control, except: [:show, :new, :create]
  before_action :require_admin, only: [:index]

  # GET /responses
  # GET /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
    @layout[:og][:title] = @response.assessment.title
    @layout[:og][:title] += ' - ' + @response.city if !@response.city.nil? && @response.city != ''
    @layout[:og][:description] = @response.assessment.subtitle
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = Response.new(response_params)
    @response.uuid = cookies[:uuid]

    respond_to do |format|
      if @response.save
        format.html { redirect_to @response, notice: 'Response was successfully created.' }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.includes(assessment: :sections, answers: :question).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      params.require(:response).permit(
        :email,
        :assessment_id,
        :city,
        :state,
        :zip,
        answers_attributes: [:id, :value, :question_id, :source])
    end

    def access_control
      if @response && (@response.uuid != cookies[:uuid])
        render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
        return false
      end
    end
end
