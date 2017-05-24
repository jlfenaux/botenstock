class SelectedBotsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin
  before_action :set_selected_bot, only: [:show, :edit, :update, :destroy]
  layout "admin"
  # GET /selected_bots
  # GET /selected_bots.json
  def index
    @selected_bots = SelectedBot.all
    @selected_bots = @selected_bots.order('end_date desc').paginate(:page => params[:page], :per_page => 20)
  end

  # GET /selected_bots/1
  # GET /selected_bots/1.json
  def show
    redirect_to selected_bots_path
  end

  # GET /selected_bots/new
  def new
    @selected_bot = SelectedBot.new
  end

  # GET /selected_bots/1/edit
  def edit
  end


  # POST /selected_bots
  # POST /selected_bots.json
  def create
    @selected_bot = SelectedBot.new(selected_bot_params)

    respond_to do |format|
      if @selected_bot.save
        format.html { redirect_to @selected_bot, notice: 'La sélection a été créée.' }
        format.json { render :show, status: :created, location: @selected_bot }
      else
        format.html { render :new }
        format.json { render json: @selected_bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /selected_bots/1
  # PATCH/PUT /selected_bots/1.json
  def update
    respond_to do |format|
      if @selected_bot.update(selected_bot_params)
        format.html { redirect_to selected_bots_path, notice: 'La sélection a été mise à jour.' }
        format.json { render :show, status: :ok, location: @selected_bot }
      else
        format.html { render :edit }
        format.json { render json: @selected_bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selected_bots/1
  # DELETE /selected_bots/1.json
  def destroy
    @selected_bot.destroy
    respond_to do |format|
      format.html { redirect_to selected_bots_url, notice: 'La sélection a été supprimée.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_selected_bot
      @selected_bot = SelectedBot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def selected_bot_params
      params.require(:selected_bot).permit(:bot_id, :start_date, :end_date)
    end
end
