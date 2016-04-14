[tags]
{% for key, value in environment('TAG_') %}{{ key }}="{{ value }}"
{% endfor %}
[agent]
interval = "10s"
round_interval = true
flush_interval = "10s"
flush_jitter = "0s"
debug = false
hostname = "{{ HOSTNAME }}"
[[outputs.influxdb]]
urls = ["{{ INFLUXDB_URL }}"] # required
database = "{{INFLUXDB_DB}}" # required
precision = "s"
[[inputs.cpu]]
percpu = true
totalcpu = true
drop = ["cpu_time"]
[[inputs.disk]]
[[inputs.diskio]]
[[inputs.mem]]
[[inputs.swap]]
[[inputs.system]]
[[inputs.docker]]
endpoint = "unix:///var/run/docker.sock"
container_names = []
