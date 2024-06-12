extends CanvasLayer

@onready var attr_item_chose = $attr_item_chose
@onready var attr_item_template = $attr_item_chose/attr_item_template

@onready var attr_list = $attr/MarginContainer/ScrollContainer/attr_list
@onready var attr_template = $attr/MarginContainer/ScrollContainer/attr_list/attr_template

@onready var refresh = $refresh
@onready var update = $update
@onready var continue_btn = $continue

const ATTR_GROUP = {
	"attack":{
		"name":"攻击力",
		"type1":{
			"name": "基础伤害叠加",
			"img": "basic_hurt"
		},
		"type2":{
			"name": "基础伤害倍数",
			"img": "basic_hurt"
		},
	},
	
	"speed":{
		"name":"速度",
		"type1":{
			"name":"移动速度",
			"img":"speed",
		}
	},
	
	"hp":{
		"name":"血量",
		"type1":{
			"name":"最大血量",
			"img":"max_hp",
		}
	},
	
	"get_add":{
		"name":"获取叠加",
		"type1":{
			"name":"金币获取叠加",
			"img":"gold_get",
		},
		"type2":{
			"name":"经验获取叠加",
			"img":"exp_get",
		}
	},
}

const attr_data = {
	"basic_hurt":{
		"group":ATTR_GROUP.attack,
		"type":"type1",
		"range":"1-5",
	},
	
	"basic_hurt_multiple":{
		"group":ATTR_GROUP.attack,
		"type":"type2",
		"range":"2-4",
	},
	
	"speed":{
		"group":ATTR_GROUP.speed,
		"type":"type1",
		"range":"50-200",
	},
	
	"max_hp":{
		"group":ATTR_GROUP.hp,
		"type":"type1",
		"range":"1-10",
	},
	
	"gold_get":{
		"group":ATTR_GROUP.get_add,
		"type":"type1",
		"range":"1-5",
	},
	
	"exp_get":{
		"group":ATTR_GROUP.get_add,
		"type":"type2",
		"range":"1-5",
	},
}

var player

func _ready():
	player = get_tree().get_first_node_in_group("player")
	attr_item_template.hide()
	attr_template.hide()
	init()
	pass

func _process(delta):
	pass

func init():
	gen_attr_choose()
	load_player_attr()
	pass

func gen_attr_choose():
	for item in attr_item_chose.get_children():
		if(item.is_visible()):
			attr_item_chose.remove_child(item)
			item.queue_free()
			
	for i in range(4):
		var attr_item = attr_item_template.duplicate()
		attr_item.show()
		
		var keys = attr_data.keys()
		var num = randi_range(0, keys.size() - 1)
		attr_item.get_node("MarginContainer/HBoxContainer/TextureRect").texture = \
		load("res://scenes/assets/" + attr_data[keys[num]].group[attr_data[keys[num]].type].img + ".png")
		
		attr_item.get_node("MarginContainer/HBoxContainer/VBoxContainer/Label").text = attr_data[keys[num]].group.name
		
		var range = attr_data[keys[num]].range.split("-")
		var attr_val = randi_range(int(range[0]), int(range[1]))
		attr_item.get_node("RichTextLabel").text = "[color=green]+" + str(attr_val) + " [/color]" \
		+ attr_data[keys[num]].group[attr_data[keys[num]].type].name
		
		attr_item.get_node("Button").pressed.connect(choose_attr.bind({
			"key": keys[num],
			"attr": attr_data[keys[num]],
			"val": attr_val,
		}))
		attr_item_chose.add_child(attr_item)
	pass

func choose_attr(attr_info):
	#player[attr_info.key] += attr_info.val
	gen_attr_choose()
	pass

func load_player_attr():
	pass
