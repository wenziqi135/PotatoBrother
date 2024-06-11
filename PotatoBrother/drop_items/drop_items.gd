extends CharacterBody2D

var canMoving = false
var speed = 1500
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	self.set_collision_layer_value(5,false)#关闭层mask
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(canMoving):
		var dir = (player.position - self.position).normalized()
		velocity = dir * speed
		move_and_slide()
	pass

"""
options.box 掉落物父级
options.ani_name 凋落物名称
options.position 凋落物坐标
options.scale 凋落物缩放等级
"""

func gen_drop_item(options):
	if(!options.has("box")):
		options.box = GameMain.duplicate_node
	var ani_temp = self.duplicate()#复制 复印
	options.box.add_child.call_deferred(ani_temp)
	ani_temp.show.call_deferred()
	ani_temp.set_collision_layer_value.call_deferred(5,true)
	ani_temp.scale = options.scale if options.has("scale") else Vector2(1,1)
	ani_temp.position = options.position
	ani_temp.get_node("all_animation").play(options.ani_name)
	pass
