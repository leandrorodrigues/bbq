class EventItemsController < ApplicationController
  before_action :set_event_item, only: [:show, :edit, :update, :destroy]
  before_action :get_event

  # GET /event_items
  # GET /event_items.json
  def index
    @event_items = EventItem.where(:event_id => @event.id).order(sort_params).page(params[:page])
  end

  # GET /event_items/1
  # GET /event_items/1.json
  def show
  end

  # GET /event_items/new
  def new
    @event_item = EventItem.new
  end

  # GET /event_items/1/edit
  def edit
  end

  # POST /event_items
  # POST /event_items.json
  def create
    @event_item = EventItem.new(event_item_params)

    respond_to do |format|
      if @event_item.save
        format.html { redirect_to  new_event_event_item_path(@event), notice: 'Event item was successfully created.' }
        format.json { render :show, status: :created, location: @event_item }
      else
        format.html { render :new }
        format.json { render json: @event_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_items/1
  # PATCH/PUT /event_items/1.json
  def update
    respond_to do |format|
      if @event_item.update(event_item_params)
        format.html { redirect_to event_event_items_url(@event), notice: 'Event item was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_item }
      else
        format.html { render :edit }
        format.json { render json: @event_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_items/1
  # DELETE /event_items/1.json
  def destroy
    @event_item.destroy
    respond_to do |format|
      format.html { redirect_to event_event_items_url(@event), notice: 'Event item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_item
      @event_item = EventItem.find(params[:id])
    end

    def get_event
      @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_item_params
      params[:event_item][:event_id] = @event.id
      params.require(:event_item).permit('event_id', 'title', 'total_price', 'per_person_price', 'child_factor', 'woman_factor', 'required_per_person')
    end
end
