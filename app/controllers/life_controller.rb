class LifeController < ApplicationController
  require 'conways-life'
  def index

  end
  # POST /life
  # POST /life.json
  def create
    @life = ConwaysLife.new(params["life"]["state"])
    Rails.logger.info( @life )
  end
end
