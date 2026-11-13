extends Node3D

@onready var Wall_Variants = [$"Walls/Wall 1",$"Walls/Wall 2",$"Walls/Wall 3",$"Walls/Wall 4",$"Walls/Wall 5",$"Walls/Wall 6",$"Walls/Wall 7",$"Walls/Wall 8",$"Walls/Wall 9",$"Walls/Wall 10",$"Walls/Wall 11",$"Walls/Wall 12"]

@onready var Score = $Player/Player_Camera/CanvasLayer/GUI/Score
@onready var warning = $"Player/Player_Camera/CanvasLayer/Big Text/Warning"
@onready var timer = $"Player/Player_Camera/CanvasLayer/Big Text/Timer"
@onready var player_perspective = $Player/Player_Camera/CanvasLayer
@onready var Player_Camera = $Player/Player_Camera

var wall_speed = 10.0 #in seconds
var difficulty
var level
var score: int = -1
var timer_on: bool = false
var max_walls: int
var moving_walls
var won: bool = false

var config = ConfigFile.new()
var config_path = "user://Config.cfg"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	config.load(config_path)
	if config.get_value("LEVEL OPTIONS", "infinite", false):
		difficulty = config.get_value("LEVEL OPTIONS", "difficulty", 0)
		Infinite()
	if config.get_value("LEVEL OPTIONS", "levels"):
		level = config.get_value("LEVEL OPTIONS", "level")
	if level:
		var level_function = "Level" + str(level)
		if has_method(level_function):
			call(level_function)
		
	
	Score.visible = false
	for Wall in get_tree().get_nodes_in_group("Walls"):
		Wall.visible = false
	await get_tree().create_timer(0.5, false).timeout
	var fade_out = create_tween()
	fade_out.tween_property($"Player/Player_Camera/CanvasLayer/Black Fade", "modulate:a", 0.0, 1)
	await fade_out.finished

func starting():
	var countdown = 4
	for i in range(3):
		warning.text = "Starting in: "+str(countdown-1)
		countdown = countdown - 1
		await get_tree().create_timer(1.0, false).timeout
	warning.text = ""
	
	timer.start()
	timer_on = true
	go_time()

func Level1():
	timer.wait_time = 31.0
	
	wall_speed = 10
	max_walls = 1
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level2():
	timer.wait_time = 31.0
	
	wall_speed = 10
	max_walls = 2
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level3():
	timer.wait_time = 46.0
	
	wall_speed = 10
	max_walls = 3
	
	await get_tree().create_timer(1.0, false).timeout
	starting()
	
func Level4():
	timer.wait_time = 46.0
	
	wall_speed = 10
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level5():
	timer.wait_time = 61.0
	
	wall_speed = 8
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Infinite():
	if difficulty == 0:
		wall_speed = 10
		max_walls = 2
	elif difficulty == 1:
		wall_speed = 8
		max_walls = 3
	elif difficulty == 2:
		wall_speed = 6
		max_walls = 4
	elif difficulty == 3:
		wall_speed = 3
		max_walls = 4
	
	var countdown = 4
	for i in range(3):
		warning.text = "Starting in: "+str(countdown-1)
		countdown = countdown - 1
		await get_tree().create_timer(1.0, false).timeout
	warning.text = ""	
	
	Score.visible = true
	go_time()
	
func go_time():
	var directions = [1, 2, 3, 4]
	directions.shuffle()
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
	var time
	Score.text = "Score: " + str(score)
	if timer_on:
		time = int(timer.time_left)
		var seconds = time % 60
		var minutes = floori(time / 60)
		if seconds < 10:
			seconds = "0" + str(seconds)
		warning.text = str(minutes) +":"+ str(seconds)
		
	if not player_perspective.dead and Player_Camera.global_position.y > -12 and time == 0:
		won = true
		if won:
			timer_on = false
			await get_tree().create_timer(5.0, false).timeout
			var fade_out = create_tween()
			fade_out.tween_property($"Player/Player_Camera/CanvasLayer/Black Fade", "modulate:a", 1.0, 1)
			await fade_out.finished
			await get_tree().create_timer(0.5, false).timeout
			config.load(config_path)
			var levels_completed = config.get_value("LEVEL OPTIONS", "levels_completed")
			var level = config.get_value("LEVEL OPTIONS", "level")
			if level not in levels_completed:
				levels_completed.append(level)
			config.set_value("LEVEL OPTIONS", "levels_completed", levels_completed)
			config.save(config_path)
			won = false
			get_tree().change_scene_to_file("res://title_screen.tscn")
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
			
		
