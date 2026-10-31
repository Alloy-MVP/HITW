extends Node3D

@onready var Wall_Variant_1 = $"Walls/Wall 1"
@onready var Wall_Variant_2 = $"Walls/Wall 2"
@onready var Wall_Variant_3 = $"Walls/Wall 3"
@onready var Wall_Variant_4 = $"Walls/Wall 4"
@onready var Wall_Variant_5 = $"Walls/Wall 5"
@onready var Wall_Variant_6 = $"Walls/Wall 6"
@onready var Wall_Variant_7 = $"Walls/Wall 7"
@onready var Wall_Variant_8 = $"Walls/Wall 8"
@onready var Wall_Variant_9 = $"Walls/Wall 9"
@onready var Wall_Variant_10 = $"Walls/Wall 10"
@onready var Wall_Variant_11 = $"Walls/Wall 11"
@onready var Wall_Variant_12 = $"Walls/Wall 12"
@onready var Score = $Player/Player_Camera/CanvasLayer/GUI/Score

var wall_speed = 10 #in seconds
var score: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for Wall in get_tree().get_nodes_in_group("Walls"):
		Wall.visible = false

func go_time():
	call("WV"+(str(randi_range(1,12))))
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
	var direction = randi_range(1, 4)
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

func WV4():
	var duplicate_wv4 = Wall_Variant_4.duplicate()
	duplicate_wv4.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv4.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv4.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv4.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv4.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv4)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv4, "position", Vector3(0, 0.5, 15.5), wall_speed)
	elif direction == 2:
		wall_animation.tween_property(duplicate_wv4, "position", Vector3(0, 0.5, 0), wall_speed)
	elif direction == 3:
		wall_animation.tween_property(duplicate_wv4, "position", Vector3(15.5, 0.5, 0), wall_speed)
	elif direction == 4:
		wall_animation.tween_property(duplicate_wv4, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv4.queue_free()
	go_time()

func WV5():
	var duplicate_wv5 = Wall_Variant_5.duplicate()
	duplicate_wv5.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv5.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv5.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv5.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv5.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv5)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv5, "position", Vector3(0, 0.5, 15.5), wall_speed)
	elif direction == 2:
		wall_animation.tween_property(duplicate_wv5, "position", Vector3(0, 0.5, 0), wall_speed)
	elif direction == 3:
		wall_animation.tween_property(duplicate_wv5, "position", Vector3(15.5, 0.5, 0), wall_speed)
	elif direction == 4:
		wall_animation.tween_property(duplicate_wv5, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv5.queue_free()
	go_time()

func WV6():
	var duplicate_wv6 = Wall_Variant_6.duplicate()
	duplicate_wv6.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv6.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv6.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv6.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv6.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv6)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv6, "position", Vector3(0, 0.5, 15.5), wall_speed)
	elif direction == 2:
		wall_animation.tween_property(duplicate_wv6, "position", Vector3(0, 0.5, 0), wall_speed)
	elif direction == 3:
		wall_animation.tween_property(duplicate_wv6, "position", Vector3(15.5, 0.5, 0), wall_speed)
	elif direction == 4:
		wall_animation.tween_property(duplicate_wv6, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv6.queue_free()
	go_time()

func WV7():
	var duplicate_wv7 = Wall_Variant_7.duplicate()
	duplicate_wv7.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv7.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv7.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv7.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv7.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv7)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv7, "position", Vector3(0, 0.5, 15.5), wall_speed)
	elif direction == 2:
		wall_animation.tween_property(duplicate_wv7, "position", Vector3(0, 0.5, 0), wall_speed)
	elif direction == 3:
		wall_animation.tween_property(duplicate_wv7, "position", Vector3(15.5, 0.5, 0), wall_speed)
	elif direction == 4:
		wall_animation.tween_property(duplicate_wv7, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv7.queue_free()
	go_time()

func WV8():
	var duplicate_wv8 = Wall_Variant_8.duplicate()
	duplicate_wv8.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv8.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv8.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv8.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv8.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv8)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv8, "position", Vector3(0, 0.5, 15.5), wall_speed)
	elif direction == 2:
		wall_animation.tween_property(duplicate_wv8, "position", Vector3(0, 0.5, 0), wall_speed)
	elif direction == 3:
		wall_animation.tween_property(duplicate_wv8, "position", Vector3(15.5, 0.5, 0), wall_speed)
	elif direction == 4:
		wall_animation.tween_property(duplicate_wv8, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv8.queue_free()
	go_time()

func WV9():
	var duplicate_wv9 = Wall_Variant_9.duplicate()
	duplicate_wv9.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv9.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv9.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv9.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv9.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv9)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv9, "position", Vector3(0, 0.5, 15.5), wall_speed)
	elif direction == 2:
		wall_animation.tween_property(duplicate_wv9, "position", Vector3(0, 0.5, 0), wall_speed)
	elif direction == 3:
		wall_animation.tween_property(duplicate_wv9, "position", Vector3(15.5, 0.5, 0), wall_speed)
	elif direction == 4:
		wall_animation.tween_property(duplicate_wv9, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv9.queue_free()
	go_time()

func WV10():
	var duplicate_wv10 = Wall_Variant_10.duplicate()
	duplicate_wv10.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv10.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv10.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv10.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv10.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv10)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv10, "position", Vector3(0, 0.5, 15.5), wall_speed)
	elif direction == 2:
		wall_animation.tween_property(duplicate_wv10, "position", Vector3(0, 0.5, 0), wall_speed)
	elif direction == 3:
		wall_animation.tween_property(duplicate_wv10, "position", Vector3(15.5, 0.5, 0), wall_speed)
	elif direction == 4:
		wall_animation.tween_property(duplicate_wv10, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv10.queue_free()
	go_time()

func WV11():
	var duplicate_wv11 = Wall_Variant_11.duplicate()
	duplicate_wv11.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv11.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv11.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv11.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv11.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv11)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv11, "position", Vector3(0, 0.5, 15.5), wall_speed)
	elif direction == 2:
		wall_animation.tween_property(duplicate_wv11, "position", Vector3(0, 0.5, 0), wall_speed)
	elif direction == 3:
		wall_animation.tween_property(duplicate_wv11, "position", Vector3(15.5, 0.5, 0), wall_speed)
	elif direction == 4:
		wall_animation.tween_property(duplicate_wv11, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv11.queue_free()
	go_time()

func WV12():
	var duplicate_wv12 = Wall_Variant_12.duplicate()
	duplicate_wv12.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wv12.position = Vector3(0, 0.5, 0)
	elif direction == 2:
		duplicate_wv12.position = Vector3(0, 0.5, 15.5)
	elif direction == 3:
		duplicate_wv12.rotate_y(deg_to_rad(90))
	elif direction == 4:
		duplicate_wv12.rotate_y(deg_to_rad(-90))
	get_tree().current_scene.add_child(duplicate_wv12)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wv12, "position", Vector3(0, 0.5, 15.5), wall_speed)
	elif direction == 2:
		wall_animation.tween_property(duplicate_wv12, "position", Vector3(0, 0.5, 0), wall_speed)
	elif direction == 3:
		wall_animation.tween_property(duplicate_wv12, "position", Vector3(15.5, 0.5, 0), wall_speed)
	elif direction == 4:
		wall_animation.tween_property(duplicate_wv12, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	
	await wall_animation.finished
	duplicate_wv12.queue_free()
	go_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Score.text = "Score: " + str(score)
