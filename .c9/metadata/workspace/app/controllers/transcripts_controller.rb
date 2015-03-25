{"filter":false,"title":"transcripts_controller.rb","tooltip":"/app/controllers/transcripts_controller.rb","undoManager":{"mark":82,"position":82,"stack":[[{"group":"doc","deltas":[{"start":{"row":50,"column":17},"end":{"row":50,"column":20},"action":"remove","lines":["pdf"]},{"start":{"row":50,"column":17},"end":{"row":50,"column":18},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":50,"column":18},"end":{"row":50,"column":19},"action":"insert","lines":["x"]}]}],[{"group":"doc","deltas":[{"start":{"row":50,"column":19},"end":{"row":50,"column":20},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":68,"column":35},"end":{"row":68,"column":38},"action":"remove","lines":["PDF"]},{"start":{"row":68,"column":35},"end":{"row":68,"column":36},"action":"insert","lines":["T"]}]}],[{"group":"doc","deltas":[{"start":{"row":68,"column":36},"end":{"row":68,"column":37},"action":"insert","lines":["X"]}]}],[{"group":"doc","deltas":[{"start":{"row":68,"column":37},"end":{"row":68,"column":38},"action":"insert","lines":["T"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":39},"end":{"row":51,"column":52},"action":"remove","lines":["import_params"]},{"start":{"row":51,"column":39},"end":{"row":51,"column":40},"action":"insert","lines":["p"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":40},"end":{"row":51,"column":41},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":41},"end":{"row":51,"column":42},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":42},"end":{"row":51,"column":43},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":43},"end":{"row":51,"column":44},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":44},"end":{"row":51,"column":45},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":45},"end":{"row":51,"column":47},"action":"insert","lines":["[]"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":46},"end":{"row":51,"column":47},"action":"insert","lines":[":"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":46},"end":{"row":51,"column":47},"action":"remove","lines":[":"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":46},"end":{"row":51,"column":48},"action":"insert","lines":["\"\""]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":47},"end":{"row":51,"column":48},"action":"insert","lines":["U"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":48},"end":{"row":51,"column":49},"action":"insert","lines":["p"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":49},"end":{"row":51,"column":50},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":50},"end":{"row":51,"column":51},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":51},"end":{"row":51,"column":52},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":52},"end":{"row":51,"column":53},"action":"insert","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":47},"end":{"row":51,"column":53},"action":"remove","lines":["Upload"]},{"start":{"row":51,"column":47},"end":{"row":51,"column":57},"action":"insert","lines":["Transcript"]}]}],[{"group":"doc","deltas":[{"start":{"row":5,"column":0},"end":{"row":6,"column":0},"action":"remove","lines":["  before_action :get_ext, only: [:import]",""]}]}],[{"group":"doc","deltas":[{"start":{"row":97,"column":0},"end":{"row":99,"column":7},"action":"remove","lines":["    def get_ext","      @ext = (File.extname(params[:transcript_file].original_filename)).downcase ","    end"]}]}],[{"group":"doc","deltas":[{"start":{"row":96,"column":4},"end":{"row":97,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":96,"column":2},"end":{"row":96,"column":4},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":96,"column":0},"end":{"row":96,"column":2},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":95,"column":7},"end":{"row":96,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":95,"column":6},"end":{"row":95,"column":7},"action":"remove","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":95,"column":6},"end":{"row":95,"column":7},"action":"insert","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":50,"column":20},"end":{"row":50,"column":70},"action":"remove","lines":[" Transcript.import(params[\"Transcript\"], @user.id)"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":7},"end":{"row":49,"column":21},"action":"remove","lines":["@ext == \".txt\""]},{"start":{"row":49,"column":7},"end":{"row":49,"column":57},"action":"insert","lines":[" Transcript.import(params[\"Transcript\"], @user.id)"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":6},"end":{"row":49,"column":8},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":6},"end":{"row":49,"column":7},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":50,"column":0},"end":{"row":51,"column":0},"action":"remove","lines":["      @bad_courses =",""]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":71},"end":{"row":65,"column":98},"action":"remove","lines":["Only PDF files are accepted"]},{"start":{"row":65,"column":71},"end":{"row":65,"column":72},"action":"insert","lines":["P"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":72},"end":{"row":65,"column":73},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":73},"end":{"row":65,"column":74},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":74},"end":{"row":65,"column":75},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":75},"end":{"row":65,"column":76},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":76},"end":{"row":65,"column":77},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":77},"end":{"row":65,"column":78},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":78},"end":{"row":65,"column":79},"action":"insert","lines":["U"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":79},"end":{"row":65,"column":80},"action":"insert","lines":["p"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":80},"end":{"row":65,"column":81},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":81},"end":{"row":65,"column":82},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":82},"end":{"row":65,"column":83},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":83},"end":{"row":65,"column":84},"action":"insert","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":84},"end":{"row":65,"column":85},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":85},"end":{"row":65,"column":86},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":86},"end":{"row":65,"column":87},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":86},"end":{"row":65,"column":87},"action":"remove","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":86},"end":{"row":65,"column":87},"action":"insert","lines":["C"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":87},"end":{"row":65,"column":88},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":88},"end":{"row":65,"column":89},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":89},"end":{"row":65,"column":90},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":90},"end":{"row":65,"column":91},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":91},"end":{"row":65,"column":92},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":92},"end":{"row":65,"column":93},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":93},"end":{"row":65,"column":94},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":94},"end":{"row":65,"column":95},"action":"insert","lines":["T"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":95},"end":{"row":65,"column":96},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":96},"end":{"row":65,"column":97},"action":"insert","lines":["x"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":97},"end":{"row":65,"column":98},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":78},"end":{"row":65,"column":85},"action":"remove","lines":["Uploade"]},{"start":{"row":65,"column":78},"end":{"row":65,"column":79},"action":"insert","lines":["U"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":79},"end":{"row":65,"column":80},"action":"insert","lines":["p"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":80},"end":{"row":65,"column":81},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":81},"end":{"row":65,"column":82},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":82},"end":{"row":65,"column":83},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":83},"end":{"row":65,"column":84},"action":"insert","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":66,"column":30},"end":{"row":66,"column":57},"action":"remove","lines":["Only TXT files are accepted"]},{"start":{"row":66,"column":30},"end":{"row":66,"column":56},"action":"insert","lines":["Please Upload Correct Text"]}]}],[{"group":"doc","deltas":[{"start":{"row":48,"column":12},"end":{"row":49,"column":0},"action":"insert","lines":["",""]},{"start":{"row":49,"column":0},"end":{"row":49,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":4},"end":{"row":49,"column":5},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":5},"end":{"row":49,"column":6},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":6},"end":{"row":49,"column":7},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":7},"end":{"row":49,"column":8},"action":"insert","lines":["."]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":8},"end":{"row":49,"column":9},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":9},"end":{"row":49,"column":10},"action":"insert","lines":["p"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":10},"end":{"row":49,"column":11},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":11},"end":{"row":49,"column":12},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":12},"end":{"row":49,"column":13},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":49,"column":0},"end":{"row":50,"column":0},"action":"remove","lines":["    nil.split",""]}]}]]},"ace":{"folds":[],"scrolltop":387,"scrollleft":0,"selection":{"start":{"row":49,"column":0},"end":{"row":49,"column":0},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":26,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1426904650642,"hash":"1ab750b920229ddf3ad983cbde00197044a11c85"}