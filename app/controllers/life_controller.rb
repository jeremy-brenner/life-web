class LifeController < ApplicationController

  def index

  end
  # POST /life
  # POST /life.json
  def create # create life!
    @life = ConwaysLife.new(params["life"]["state"]).tick
    @state_list = 10.times.map { @life.tick.state  }
    @timestamp = params["life"]["timestamp"]
  end
end
