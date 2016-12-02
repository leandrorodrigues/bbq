class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :edit, :update, :destroy]
  before_action :set_event

  # GET /participations
  # GET /participations.json
  def index
    @participations = Participation.where(:event_id => @event.id).order(sort_params).page(params[:page])
  end

  # GET /participations/1
  # GET /participations/1.json
  def show
  end

  def new
    @participation = Participation.new
  end


  # GET /participations/1/edit
  def edit
  end

  def create
    @participation = Participation.new(participation_params)

    respond_to do |format|
      if @participation.save
        format.html { redirect_to event_participations_path(@event) , notice: 'Participation was successfully created.' }
        format.json { render :show, status: :created, location: @participation }
      else
        format.html { render :new }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participations/1
  # PATCH/PUT /participations/1.json
  def update
    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to event_participations_url(@event), notice: 'Participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @participation.destroy
    respond_to do |format|
      format.html { redirect_to event_participations_url, notice: 'Participation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participation
      @participation = Participation.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participation_params
      params.required(:participation).permit(:user_id, :event_id, :name, :kind, event_item_ids: [])
    end
end
