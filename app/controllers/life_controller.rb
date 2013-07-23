class LifeController < ApplicationController

  def index
    @presets = { 
      'Pulsar'             => "7,12:8,12:9,12:11,11:11,13:13,12:14,12:15,12",
      'Gosper Glider Gun'  => "5,1:5,2:6,2:6,1:5,11:6,11:7,11:4,12:3,13:3,14:8,12:9,13:9,14:6,15:4,16:5,17:6,17:7,17:8,16:6,18:5,21:5,22:4,21:4,22:3,21:3,22:2,23:6,23:6,25:7,25:2,25:1,25:3,35:4,35:4,36:3,36",
      'Spinners'           => "7,12:8,12:9,12:7,16:8,16:9,16" ,
      'Queen Bee'          => "20,27:21,26:21,28:22,25:22,29:23,26:23,27:23,28:24,29:24,30:24,25:24,24",
      'Butterfly'          => "10,11:11,11:12,11:11,12:13,12:13,13:13,14:12,13",
      'Cauldron'           => "5,12:6,11:7,12:6,13:9,10:9,11:9,12:9,13:9,14:10,9:10,15:11,10:12,10:13,10:11,14:12,14:13,14:14,11:14,12:14,13:17,11:16,12:16,11:17,13:17,14:16,14:11,8:11,7:10,7:11,16:11,17:10,17",
      'Carnival Shuttle'   => "4,3:4,4:5,4:6,4:7,4:8,4:8,3:6,5:5,6:7,6:6,7:4,8:6,8:5,8:7,8:8,8:8,9:4,9:6,11:6,12:5,12:7,12:5,15:7,15:6,16:6,17:7,22:6,22:5,22:6,26:6,31:4,36:8,38:4,38:6,37:7,23:5,23:6,23:7,27:6,27:5,27:5,30:7,30:6,32:8,36:3,36:9,36:4,37:7,38:5,38:6,39:8,37:8,39:8,40:9,40:4,39:4,40:3,40",
      'Roteightor'         => "4,5:5,5:5,6:5,7:6,8:7,8:7,7:10,9:11,9:12,9:13,10:10,10:10,11:11,12:13,7:14,7:13,6:14,5:15,5:16,5:16,4:8,14:7,14:8,15:7,16:6,16:5,16:5,17:13,14:14,14:15,13:16,14:16,15:16,16:17,16",
      'Switch Engine'      => "20,16:21,16:22,16:21,17:22,19:24,19:25,18:24,17",
      'Lotus'              => "22,33:23,33:24,34:23,35:22,35:22,34:24,33:24,35:27,33:26,33:26,34:26,35:27,35"
    }
  end
  # POST /life
  # POST /life.json
  def create # create life!
    @life = ConwaysLife.new(params["life"]["state"])
    @state_list = 20.times.map { @life.tick.state  }
    @timestamp = params["life"]["timestamp"]
  end
end
