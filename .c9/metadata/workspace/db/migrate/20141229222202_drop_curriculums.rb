{"filter":false,"title":"20141229222202_drop_curriculums.rb","tooltip":"/db/migrate/20141229222202_drop_curriculums.rb","undoManager":{"mark":18,"position":18,"stack":[[{"group":"doc","deltas":[{"start":{"row":1,"column":0},"end":{"row":2,"column":5},"action":"remove","lines":["  def change","  end"]},{"start":{"row":1,"column":0},"end":{"row":13,"column":5},"action":"insert","lines":["def up","    drop_table :tablename","  end","","  def down","    create_table :tablename do |t|","      t.string :table_column","      t.references :anothertable","","      t.timestamps        ","    end","    add_index :tablenames, :anothertable_id","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":1,"column":0},"end":{"row":1,"column":2},"action":"insert","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":16},"end":{"row":2,"column":25},"action":"remove","lines":["tablename"]},{"start":{"row":2,"column":16},"end":{"row":2,"column":17},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":17},"end":{"row":2,"column":18},"action":"insert","lines":["u"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":18},"end":{"row":2,"column":19},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":19},"end":{"row":2,"column":20},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":20},"end":{"row":2,"column":21},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":21},"end":{"row":2,"column":22},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":22},"end":{"row":2,"column":23},"action":"insert","lines":["u"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":23},"end":{"row":2,"column":24},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":24},"end":{"row":2,"column":25},"action":"insert","lines":["u"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":25},"end":{"row":2,"column":26},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":6,"column":18},"end":{"row":6,"column":27},"action":"remove","lines":["tablename"]},{"start":{"row":6,"column":18},"end":{"row":6,"column":28},"action":"insert","lines":["curriculum"]}]}],[{"group":"doc","deltas":[{"start":{"row":0,"column":20},"end":{"row":0,"column":21},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":26},"end":{"row":2,"column":27},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":6,"column":28},"end":{"row":6,"column":29},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":7,"column":6},"end":{"row":7,"column":28},"action":"remove","lines":["t.string :table_column"]},{"start":{"row":7,"column":6},"end":{"row":7,"column":39},"action":"insert","lines":["t.belongs_to :course, index: true"]}]}],[{"group":"doc","deltas":[{"start":{"row":8,"column":0},"end":{"row":9,"column":0},"action":"remove","lines":["      t.references :anothertable",""]}]}],[{"group":"doc","deltas":[{"start":{"row":11,"column":0},"end":{"row":12,"column":0},"action":"remove","lines":["    add_index :tablenames, :anothertable_id",""]}]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":11,"column":0},"end":{"row":11,"column":0},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1419891841104,"hash":"e32cdca0f6c5ff624359839bf717943ab19f4112"}