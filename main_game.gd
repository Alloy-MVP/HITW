extends Node3D

@onready var Wall_Variants = [$"Walls/Wall 1",$"Walls/Wall 2",$"Walls/Wall 3",$"Walls/Wall 4",$"Walls/Wall 5",$"Walls/Wall 6",$"Walls/Wall 7",$"Walls/Wall 8",$"Walls/Wall 9",$"Walls/Wall 10",$"Walls/Wall 11",$"Walls/Wall 12"]

@onready var Score = $Player/Player_Camera/CanvasLayer/GUI/Score

@onready var warning = $"Player/Player_Camera/CanvasLayer/Big Text/Warning"

var wall_speed = 4 #in seconds
var score: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Score.visible = false
	for Wall in get_tree().get_nodes_in_group("Walls"):
		Wall.visible = false
	level1()

func level1():
	var countdown = 4
	for i in range(3):
		warning.text = "Starting in: "+str(countdown-1)
		countdown = countdown - 1
		await get_tree().create_timer(1.0, false).timeout
	warning.text = "GO!!!"
	await get_tree().create_timer(1.0, false).timeout
	Score.visible = true
	go_time()
	var fade = create_tween()
	fade.tween_property(warning, "modulate:a", 0.0, 2.0)
	await fade.finished

func go_time():
	var real_wall = randi_range(0, 3)
	for i in range(4):
		var index = randi_range(0, 11)
		var real_wv: bool
		if i == real_wall:
			real_wv = true
		else:
			real_wv = false
		Walls(Wall_Variants[index], real_wv)
	score += 1

func Walls(variant: GridMap, real: bool):
	var duplicate_wall = variant.duplicate()
	duplicate_wall.visible = true
	var direction = randi_range(1, 4)
	if direction == 1:
		duplicate_wall.position = Vector3(0, 0.5, -15.5)
	elif direction == 2:
		duplicate_wall.position = Vector3(0, 0.5, 30.5)
	elif direction == 3:
		duplicate_wall.rotate_y(deg_to_rad(90))
		duplicate_wall.position.x = global_position.x - 15.0
	elif direction == 4:
		duplicate_wall.rotate_y(deg_to_rad(-90))
		duplicate_wall.position.x = global_position.x + 15.0
	get_tree().current_scene.add_child(duplicate_wall)
	
	var wall_animation = create_tween()
	
	if direction == 1:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 15.5), wall_speed)
	if direction == 2:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 15.5), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed)
	if direction == 3:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(15.5, 0.5, 0), wall_speed)
	if direction == 4:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	await wall_animation.finished
	duplicate_wall.queue_free()
	if real:
		go_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Score.text = "Score: " + str(score)
