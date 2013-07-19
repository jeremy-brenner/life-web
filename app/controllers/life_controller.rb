class LifeController < ApplicationController

  def index
  end
  # POST /life
  # POST /life.json
  def create
    @life = ConwaysLife.new(params)
  end
end
