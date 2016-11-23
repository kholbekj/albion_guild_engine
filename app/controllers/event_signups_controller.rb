class EventSignupsController < ApplicationController
  before_action :set_event_signup, only: [:show, :edit, :update, :destroy]

  # GET /event_signups
  # GET /event_signups.json
  def index
    @event_signups = EventSignup.all
  end

  # GET /event_signups/1
  # GET /event_signups/1.json
  def show
  end

  # GET /event_signups/new
  def new
    @event_signup = EventSignup.new
  end

  # GET /event_signups/1/edit
  def edit
  end

  def signup
    event = Event.find(params[:event_id])
    current_user.sign_or_unsign_for_event(event)
    redirect_to calendar_path
  end

  # POST /event_signups
  # POST /event_signups.json
  def create
    @event_signup = EventSignup.new(event_signup_params)

    respond_to do |format|
      if @event_signup.save
        format.html { redirect_to @event_signup, notice: 'Event signup was successfully created.' }
        format.json { render :show, status: :created, location: @event_signup }
      else
        format.html { render :new }
        format.json { render json: @event_signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_signups/1
  # PATCH/PUT /event_signups/1.json
  def update
    respond_to do |format|
      if @event_signup.update(event_signup_params)
        format.html { redirect_to @event_signup, notice: 'Event signup was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_signup }
      else
        format.html { render :edit }
        format.json { render json: @event_signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_signups/1
  # DELETE /event_signups/1.json
  def destroy
    @event_signup.destroy
    respond_to do |format|
      format.html { redirect_to event_signups_url, notice: 'Event signup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_signup
      @event_signup = EventSignup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_signup_params
      params.fetch(:event_signup, {})
    end
end
