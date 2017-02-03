class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin
  layout "admin"
  # GET /bots
  # GET /bots.json
  def index
  end
 end
