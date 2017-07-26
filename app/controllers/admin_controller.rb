require 'csv'

class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin
  layout "admin"
  # GET /bots
  # GET /bots.json
  def index
  end

  def update_bots
  end

  def manage_bots
    @results = []
    content = open(params[:bots]).read

    CSV.parse(content, col_sep: ";", quote_char: "\x00") do |row|
      if Bot.where(name: row[0]).count >0
        status = %(<span class="label label-default">Aready present</span>)
      else
        Bot.create(
          name: row[0],
          description_en: "#{row[2]}\n<a href='#{row[1]}'>#{row[1]}</a>\nCategory: #{row[3]}",
          status: 'pending'
          )
      end
      @results << {
        name: row[0],
        status: status
      }
    end
  end
end
