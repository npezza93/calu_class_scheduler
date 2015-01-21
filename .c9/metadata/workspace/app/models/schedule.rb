{"filter":false,"title":"schedule.rb","tooltip":"/app/models/schedule.rb","undoManager":{"mark":-1,"position":-1,"stack":[[{"group":"doc","deltas":[{"start":{"row":75,"column":2},"end":{"row":75,"column":4},"action":"insert","lines":["# "]},{"start":{"row":76,"column":2},"end":{"row":76,"column":4},"action":"insert","lines":["# "]},{"start":{"row":77,"column":2},"end":{"row":77,"column":4},"action":"insert","lines":["# "]}]}],[{"group":"doc","deltas":[{"start":{"row":75,"column":2},"end":{"row":75,"column":4},"action":"remove","lines":["# "]}]}],[{"group":"doc","deltas":[{"start":{"row":76,"column":2},"end":{"row":76,"column":4},"action":"remove","lines":["# "]}]}],[{"group":"doc","deltas":[{"start":{"row":76,"column":2},"end":{"row":76,"column":4},"action":"insert","lines":["# "]}]}],[{"group":"doc","deltas":[{"start":{"row":77,"column":2},"end":{"row":77,"column":4},"action":"remove","lines":["# "]}]}],[{"group":"doc","deltas":[{"start":{"row":16,"column":0},"end":{"row":17,"column":0},"action":"insert","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":0},"end":{"row":17,"column":74},"action":"insert","lines":["start_time_in_q = Time.strptime(offering.days_time.start_time, \"%l:%M %P\")"]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":0},"end":{"row":17,"column":2},"action":"insert","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":2},"end":{"row":17,"column":4},"action":"insert","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":36},"end":{"row":17,"column":44},"action":"insert","lines":["schedule"]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":44},"end":{"row":17,"column":45},"action":"insert","lines":["."]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":0},"end":{"row":19,"column":0},"action":"remove","lines":["    start_time_in_q = Time.new(2000,1,1,schedule.offering.days_time.start_time.split(\":\")[0],schedule.offering.days_time.start_time.split(\":\")[1]) ",""]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":87},"end":{"row":18,"column":0},"action":"insert","lines":["",""]},{"start":{"row":18,"column":0},"end":{"row":18,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":2},"end":{"row":18,"column":4},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":0},"end":{"row":18,"column":2},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":0},"end":{"row":19,"column":0},"action":"insert","lines":["      end_time_in_q = Time.strptime(offering.days_time.end_time, \"%l:%M %P\")",""]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":4},"end":{"row":18,"column":6},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":34},"end":{"row":18,"column":42},"action":"insert","lines":["schedule"]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":42},"end":{"row":18,"column":43},"action":"insert","lines":["."]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":0},"end":{"row":21,"column":0},"action":"remove","lines":["    end_time_in_q = Time.new(2000,1,1,schedule.offering.days_time.end_time.split(\":\")[0],schedule.offering.days_time.end_time.split(\":\")[1]) ",""]}]}],[{"group":"doc","deltas":[{"start":{"row":19,"column":0},"end":{"row":20,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":0},"end":{"row":28,"column":7},"action":"remove","lines":["    if schedule.offering.days_time.start_time.split(\" \")[1] == \"pm\"","      start_time_in_q += 12.hours","    end","    ","    if schedule.offering.days_time.end_time.split(\" \")[1] == \"pm\"","      end_time_in_q += 12.hours","    end"]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":0},"end":{"row":23,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":0},"end":{"row":23,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":23},"end":{"row":25,"column":88},"action":"insert","lines":["Time.strptime(schedule.offering.days_time.start_time, \"%l:%M %P\")"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":88},"end":{"row":25,"column":159},"action":"remove","lines":["Time.new(2000,1,1,off_time[1].split(\":\")[0], off_time[1].split(\":\")[1])"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":37},"end":{"row":25,"column":75},"action":"remove","lines":["schedule.offering.days_time.start_time"]},{"start":{"row":25,"column":37},"end":{"row":25,"column":38},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":38},"end":{"row":25,"column":39},"action":"insert","lines":["f"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":39},"end":{"row":25,"column":40},"action":"insert","lines":["f"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":40},"end":{"row":25,"column":41},"action":"insert","lines":["_"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":41},"end":{"row":25,"column":42},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":42},"end":{"row":25,"column":43},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":43},"end":{"row":25,"column":44},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":44},"end":{"row":25,"column":45},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":45},"end":{"row":25,"column":47},"action":"insert","lines":["[]"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":46},"end":{"row":25,"column":47},"action":"insert","lines":["1"]}]}],[{"group":"doc","deltas":[{"start":{"row":26,"column":21},"end":{"row":26,"column":93},"action":"remove","lines":["Time.new(2000,1,1,off_time[2].split(\":\")[0], off_time[2].split(\":\")[1]) "]},{"start":{"row":26,"column":21},"end":{"row":26,"column":59},"action":"insert","lines":["Time.strptime(off_time[1], \"%l:%M %P\")"]}]}],[{"group":"doc","deltas":[{"start":{"row":26,"column":44},"end":{"row":26,"column":45},"action":"remove","lines":["1"]}]}],[{"group":"doc","deltas":[{"start":{"row":26,"column":44},"end":{"row":26,"column":45},"action":"insert","lines":["2"]}]}],[{"group":"doc","deltas":[{"start":{"row":28,"column":0},"end":{"row":34,"column":9},"action":"remove","lines":["      if off_time[1].split(\" \")[1] == \"pm\"","        start_off_time += 12.hours","      end","      ","      if off_time[1].split(\" \")[1] == \"pm\"","        end_off_time += 12.hours","      end"]}]}],[{"group":"doc","deltas":[{"start":{"row":27,"column":0},"end":{"row":28,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":26,"column":59},"end":{"row":27,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":60,"column":2},"end":{"row":60,"column":4},"action":"remove","lines":["# "]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":4},"end":{"row":17,"column":6},"action":"insert","lines":["# "]},{"start":{"row":18,"column":4},"end":{"row":18,"column":6},"action":"insert","lines":["# "]},{"start":{"row":20,"column":4},"end":{"row":20,"column":6},"action":"insert","lines":["# "]},{"start":{"row":22,"column":4},"end":{"row":22,"column":6},"action":"insert","lines":["# "]},{"start":{"row":24,"column":4},"end":{"row":24,"column":6},"action":"insert","lines":["# "]},{"start":{"row":25,"column":4},"end":{"row":25,"column":6},"action":"insert","lines":["# "]},{"start":{"row":26,"column":4},"end":{"row":26,"column":6},"action":"insert","lines":["# "]},{"start":{"row":28,"column":4},"end":{"row":28,"column":6},"action":"insert","lines":["# "]},{"start":{"row":29,"column":4},"end":{"row":29,"column":6},"action":"insert","lines":["# "]},{"start":{"row":30,"column":4},"end":{"row":30,"column":6},"action":"insert","lines":["# "]},{"start":{"row":31,"column":4},"end":{"row":31,"column":6},"action":"insert","lines":["# "]},{"start":{"row":32,"column":4},"end":{"row":32,"column":6},"action":"insert","lines":["# "]},{"start":{"row":33,"column":4},"end":{"row":33,"column":6},"action":"insert","lines":["# "]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":4},"end":{"row":17,"column":6},"action":"remove","lines":["# "]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":4},"end":{"row":17,"column":6},"action":"insert","lines":["# "]}]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":75,"column":2},"end":{"row":75,"column":2},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1420669362037,"hash":"0d5c1fad47480033df35f3ca47a9b3e6df71c178"}