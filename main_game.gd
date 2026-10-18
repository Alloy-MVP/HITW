extends Node3D

@onready var Wall_Variant_1 = $"Wall 1"
@onready var Wall_Variant_2 = $"Wall 2"
@onready var Wall_Variant_3 = $"Wall 3"
@onready var Score = $Player/Player_Camera/CanvasLayer/Score

var wall_speed = 10 #in seconds
var score:int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Wall_Variant_1.visible = false
	Wall_Variant_2.visible = false
	Wall_Variant_3.visible = false
	go_time()

func go_time():
	await get_tree().create_timer(2.0)
	call("WV"+(str(randi_range(1,3))))
	score += 1

func WV1():
	var duplicate_wv1 = Wall_Variant_1.duplicate()
	duplicate_wv1.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv1.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv1.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv1.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv1.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv1)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv1, "position", Vector3(0, 0.5, 15.5), wall_speed)
	if direction == 2:
		wall_animation.tween_property(duplicate_wv1, "position", Vector3(0, 0.5, 0), wall_speed)
	if direction == 3:
		wall_animation.tween_property(duplicate_wv1, "position", Vector3(15.5, 0.5, 0), wall_speed)
	if direction == 4:
		wall_animation.tween_property(duplicate_wv1, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv1.queue_free()
	go_time()
	
func WV2():
	var duplicate_wv2 = Wall_Variant_2.duplicate()
	duplicate_wv2.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv2.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv2.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv2.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv2.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv2)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv2, "position", Vector3(0, 0.5, 15.5), wall_speed)
	if direction == 2:
		wall_animation.tween_property(duplicate_wv2, "position", Vector3(0, 0.5, 0), wall_speed)
	if direction == 3:
		wall_animation.tween_property(duplicate_wv2, "position", Vector3(15.5, 0.5, 0), wall_speed)
	if direction == 4:
		wall_animation.tween_property(duplicate_wv2, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv2.queue_free()
	go_time()

func WV3():
	var duplicate_wv3 = Wall_Variant_3.duplicate()
	duplicate_wv3.visible = true
	var direction = randi_range(3, 4)
	if direction == 1:
		duplicate_wv3.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv3.position = Vector3(0, 0.5, -15.5)
	elif direction == 3:
		duplicate_wv3.rotate_y(deg_to_rad(90))
		duplicate_wv3.position = Vector3(0, 0.5, 0)
	elif direction == 4:
		duplicate_wv3.rotate_y(deg_to_rad(-90))
		duplicate_wv3.position = Vector3(0, 0.5, 0)
	get_tree().current_scene.add_child(duplicate_wv3)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv3, "position", Vector3(0, 0.5, -15.5), wall_speed)
	if direction == 2:
		wall_animation.tween_property(duplicate_wv3, "position", Vector3(0, 0.5, 0), wall_speed)
	if direction == 3:
		wall_animation.tween_property(duplicate_wv3, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	if direction == 4:
		wall_animation.tween_property(duplicate_wv3, "position", Vector3(15.5, 0.5, 0), wall_speed)
		
	await wall_animation.finished
	duplicate_wv3.queue_free()
	go_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Score.text = "Score: " + str(score)
