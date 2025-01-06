[
  {
    platform = "template";
    sensors.maybe_dafphone_charging = {
      friendly_name = "dafphone";
      value_template = ''
        {% if is_state('binary_sensor.phone_is_charging', 'on') %}
          charging
        {% else %}
          not charging
        {% endif %}
      '';
      unique_id = "dafos.sensor.maybe_dafphone_charging";
    };
  }
  {
    platform = "template";
    sensors.maybe_dashboard_warning = {
      friendly_name = "Maybe Dashboard Warning";
      value_template = ''
        {{ label_entities('dashboard-warning') | expand | selectattr('state', 'eq', 'on') | map(attribute='entity_id') | list | count > 0 }}
      '';
      unique_id = "dafos.sensor.maybe_dashboard_warning";
    };
  }
  {
    platform = "history_stats";
    entity_id = "sensor.veranda_tv_plug_power";
    state = "off";
    name = "Véranda · daftv Power Stats";
    unique_id = "dafos.sensor.veranda_daftv_power_stats";
    end = "{{ now() }}";
    duration.hours = 6;
  }
  {
    platform = "history_stats";
    entity_id = "sensor.desk_plug_power";
    state = "off";
    name = "Desk · dafbox Power Stats";
    unique_id = "dafos.sensor.desk_dafbox_power_stats";
    end = "{{ now() }}";
    duration.hours = 6;
  }
]
