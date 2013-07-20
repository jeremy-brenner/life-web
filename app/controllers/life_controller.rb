class LifeController < ApplicationController

  def index

  end
  # POST /life
  # POST /life.json
  def create
    @life = ConwaysLife.new(params["life"]["state"])
    @life.tick
    Rails.logger.info( @life.state )
  end
end
