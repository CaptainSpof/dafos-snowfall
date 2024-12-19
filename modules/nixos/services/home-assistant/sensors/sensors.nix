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
]
