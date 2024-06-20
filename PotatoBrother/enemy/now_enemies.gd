extends Node2D

@onready var enemy = preload("res://enemy/enemy.tscn")
var tilemap = null


# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = get_tree().get_first_node_in_group("map")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var ran = RandomNumberGenerator.new()
	var num = ran.randi_range(0, len(tilemap.get_used_cells(0)) - 1)
	var body = tilemap.get_used_cells(0)[num]
	if(body.x >= 2 && body.x <= 18 && body.y >= 1 && body.y <= 7):
		var local_position = tilemap.map_to_local(body)#获取到tilemap底层的一个随机块 将其转换成坐标
		var enemyTemp = enemy.instantiate()
		enemyTemp.position = local_position * Vector2(5,5) #tilemap进行了5倍的缩放 所以对应乘5倍
		add_child(enemyTemp)

	pass # Replace with function body.

func delete_enemies():
	for n in self.get_children():
		if n.name != 'Timer':
			self.remove_child(n)
			n.queue_free()
