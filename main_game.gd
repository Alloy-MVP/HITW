extends Node3D

@onready var Wall_Variants = [$"Walls/Wall 1",$"Walls/Wall 2",$"Walls/Wall 3",$"Walls/Wall 4",$"Walls/Wall 5",$"Walls/Wall 6",$"Walls/Wall 7",$"Walls/Wall 8",$"Walls/Wall 9",$"Walls/Wall 10",$"Walls/Wall 11",$"Walls/Wall 12"]

@onready var Score = $Player/Player_Camera/CanvasLayer/GUI/Score
@onready var warning = $"Player/Player_Camera/CanvasLayer/Big Text/Warning"
@onready var timer = $"Player/Player_Camera/CanvasLayer/Big Text/Timer"

var wall_speed = 10.0 #in seconds
var difficulty
var level
var score: int = -1
var timer_on: bool = false
var max_walls: int
var moving_walls

var config = ConfigFile.new()
var config_path = "user://Config.cfg"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	config.load(config_path)
	if config.get_value("LEVEL OPTIONS", "infinite", false):
		difficulty = config.get_value("LEVEL OPTIONS", "difficulty", 0)
		if difficulty == 0:
			wall_speed = 10
		elif difficulty == 1:
			wall_speed = 8
		elif difficulty == 2:
			wall_speed = 6
		elif difficulty == 3:
			wall_speed = 3
	if config.get_value("LEVEL OPTIONS", "levels"):
		level = config.get_value("LEVEL OPTIONS", "level")
		
	
	Score.visible = false
	for Wall in get_tree().get_nodes_in_group("Walls"):
		Wall.visible = false
	timer.wait_time = 300.0
	starting()

func starting():
	var countdown = 4
	for i in range(3):
		warning.text = "Starting in: "+str(countdown-1)
		countdown = countdown - 1
		await get_tree().create_timer(1.0, false).timeout
	warning.text = ""
	if config.get_value("LEVEL OPTIONS", "infinite", false):
		Infinite()
	var level_function = "Level" + str(level)
	if has_method(level_function):
		call(level_function)

func Level1():
	timer_on = true
	await get_tree().create_timer(1.0, false).timeout
	timer.start()
	go_time()

func Infinite():
	Score.visible = true
	go_time()
	
func go_time():
	var directions = [1, 2, 3, 4]
	directions.shuffle()
	max_walls = 4
	var all_walls = randi_range(1, max_walls)
	var real_wall = randi_range(0, all_walls-1)
	moving_walls = all_walls	
	
	for i in range(all_walls):
		var index = randi_range(0, 11)
		var real_wv = false
		var queue = false
		if i == real_wall:
			real_wv = true
		else:
			real_wv = false
		
		if not real_wv and max_walls > 1 and (randi_range(1,2) == 1):
			queue = true
			
		var direction = directions[i]
		Walls(Wall_Variants[index], real_wv, direction, queue)
	score += 1

func Walls(variant: GridMap, real: bool, direction, queue):
	var duplicate_wall = variant.duplicate()
	duplicate_wall.visible = true
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
		elif queue:
			wall_animation.tween_interval(wall_speed)
			wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 15.5), wall_speed)
	if direction == 2:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 15.5), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed)
		elif queue:
			wall_animation.tween_interval(wall_speed)
			wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed)
	if direction == 3:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(15.5, 0.5, 0), wall_speed)
		elif queue:
			wall_animation.tween_interval(wall_speed)
			wall_animation.tween_property(duplicate_wall, "position", Vector3(15.5, 0.5, 0), wall_speed)
	if direction == 4:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(-15.5, 0.5, 0), wall_speed)
		elif queue:
			wall_animation.tween_interval(wall_speed)
			wall_animation.tween_property(duplicate_wall, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	await wall_animation.finished
	duplicate_wall.queue_free()
	
	moving_walls -= 1
	if moving_walls <= 0:
		go_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Score.text = "Score: " + str(score)
	if timer_on:
		var time = int(timer.time_left)
		var seconds = time % 60
		var minutes = floori(time / 60)
		if seconds < 10:
			seconds = "0" + str(seconds)
		warning.text = str(minutes) +":"+ str(seconds)
