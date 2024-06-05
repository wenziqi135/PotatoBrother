extends CharacterBody2D

@onready var playerAni:AnimatedSprite2D = $playerAni

var dir = Vector2.ZERO
var speed = 700
var flip = false
var canMove = true
var stop = false

# Called when the node enters the scene tree for the first time.
func _ready():
	choosePlayer("player2")
	pass # Replace with function body.

func choosePlayer(type):
	var player_path = "res://player/assets/"
	playerAni.sprite_frames.clear_all()
	var sprite_frame_custom = SpriteFrames.new()
	sprite_frame_custom.add_animation("default1")
	sprite_frame_custom.set_animation_loop("default1", true)
	var texture_size = Vector2(960, 240)#一张sprite_sheet的大小
	var sprite_size = Vector2(240,240)
	var full_texture:Texture = load(player_path + type + "/" + type + "-sheet.png")
	var num_columns = int(texture_size.x / sprite_size.x)
	var num_row = int(texture_size.y / sprite_size.y)
	for x in range(num_columns):
		for y in range(num_row):
			var frame = AtlasTexture.new()#创建一帧 这一帧的atlas图集从xxx-sheet中拿到
			frame.atlas = full_texture
			frame.region = Rect2(Vector2(x,y) * sprite_size, sprite_size)
			sprite_frame_custom.add_frame("default1", frame)
	playerAni.sprite_frames = sprite_frame_custom
	playerAni.play("default1")

	var str1 = "str{index}"
	print(str1.format({"index":"test"}))
	var str2 = "str{0}{1}"
	print(str2.format(["test1", "test2"]))
	var str3 = "str%o"
	print(str3%1234)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var self_pos = position

	if(mouse_pos.x >= self_pos.x):
		flip = false
	else:
		flip = true
	playerAni.flip_h = flip

	dir = (mouse_pos - self_pos).normalized()#越远就越接近abs1

	if(canMove && stop == false):
		velocity = dir * speed
		move_and_slide()

	pass

func _input(event):
	if(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed()):
		canMove = false
	if(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_pressed()):
		canMove = true




func _on_stop_mouse_exited():
	stop = false
	pass # Replace with function body.

func _on_stop_mouse_entered():
	stop = true
	pass # Replace with function body.
