[
  {
    platform = "template";
    sensors.global_maybe_home_occupied = {
      friendly_name = "Global · Home is Occupied";
      value_template = ''{{ states('zone.home') | int > 0 }}'';
      device_class = "occupancy";
    };
  }
  {
    platform = "template";
    sensors.veranda_maybe_daftv_running = {
      friendly_name = "Véranda · daftv is running";
      value_template = ''{{ not(states('sensor.veranda_tv_plug_power') | float < 25 and states('media_player.daftv') == 'off') }}'';
      device_class = "running";
    };
  }
  {
    platform = "template";
    sensors.desk_maybe_dafbox_running = {
      friendly_name = "Desk · dafbox is running";
      value_template = ''{{ not(states('sensor.desk_plug_power') | float < 25 and states('device_tracker.dafbox') == 'not_home') }}'';
      device_class = "running";
    };
  }
]
