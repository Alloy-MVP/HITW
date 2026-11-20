extends Node3D

@onready var Wall_Variants = [$"Walls/Wall 1",$"Walls/Wall 2",$"Walls/Wall 3",$"Walls/Wall 4",$"Walls/Wall 5",$"Walls/Wall 6",$"Walls/Wall 7",$"Walls/Wall 8",$"Walls/Wall 9",$"Walls/Wall 10",$"Walls/Wall 11",$"Walls/Wall 12"]

@onready var Score = $Player/Player_Camera/CanvasLayer/GUI/Score
@onready var warning = $"Player/Player_Camera/CanvasLayer/Big Text/Warning"
@onready var important_text_top = $"Player/Player_Camera/CanvasLayer/Bigger Text/top"
@onready var important_text_bottom = $"Player/Player_Camera/CanvasLayer/Bigger Text/bottom"
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
var ice_trap
var ice: bool = false
var config = ConfigFile.new()
var config_path = "user://Config.cfg"
var trap_start_time
var traps_on: bool = false

signal snap_floor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	snap_floor.connect($wharf.Snap_Floor)

	config.load(config_path)
	ice_trap = config.get_value("LEVEL OPTIONS", "traps", false)

	if config.get_value("LEVEL OPTIONS", "infinite", false):
		difficulty = config.get_value("LEVEL OPTIONS", "difficulty", 0)
		Infinite()
	if config.get_value("LEVEL OPTIONS", "levels", true):
		level = config.get_value("LEVEL OPTIONS", "level", 1)
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
	warning.visible = true
	$"Player/Player_Camera/CanvasLayer/Bigger Text".visible = true
	var countdown = 4
	var start_time = 10
	for i in range(10):
		warning.text = "GAME STARTING IN: 00:0"+str(start_time)
		start_time = start_time - 1
		if i > 6:
			countdown = countdown - 1
			important_text_top.text = "Starting in"
			important_text_bottom.text = ">"+str(countdown)+"<"
		await get_tree().create_timer(1.0, false).timeout
		
	important_text_top.text = ""
	important_text_bottom.text = ""
	warning.text = ""
	warning.visible = false
	$"Player/Player_Camera/CanvasLayer/Bigger Text".visible = false
	
	trap_start_time = floori(float(timer.wait_time / 2))
	print(trap_start_time)
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

func Level6():
	timer.wait_time = 61.0
	
	wall_speed = 8
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level7():
	timer.wait_time = 61.0
	
	wall_speed = 7
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level8():
	timer.wait_time = 61.0
	
	wall_speed = 7
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level9():
	timer.wait_time = 101.0
	
	wall_speed = 6
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level10():
	timer.wait_time = 121.0
	
	wall_speed = 6
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level11():
	timer.wait_time = 151.0
	
	wall_speed = 5
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level12():
	timer.wait_time = 171.0
	
	wall_speed = 5
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level13():
	timer.wait_time = 201.0
	
	wall_speed = 5
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level14():
	timer.wait_time = 231.0
	
	wall_speed = 4
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level15():
	timer.wait_time = 251.0
	
	wall_speed = 4
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level16():
	timer.wait_time = 271.0
	
	wall_speed = 4
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level17():
	timer.wait_time = 301.0
	
	wall_speed = 4
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level18():
	timer.wait_time = 251.0
	
	wall_speed = 3
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level19():
	timer.wait_time = 271.0
	
	wall_speed = 3
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Level20():
	timer.wait_time = 301.0
	
	wall_speed = 3
	max_walls = 4
	
	await get_tree().create_timer(1.0, false).timeout
	starting()

func Traps():
	important_text_bottom.text = "ICEY⚠⚠⚠"
	$"Player/Player_Camera/CanvasLayer/Bigger Text".visible = true
	await get_tree().create_timer(1.0, false).timeout
	ice = true
	var fade_out = create_tween()
	fade_out.tween_property(important_text_bottom, "modulate:a", 0.0, 1.0)

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
	
	if ice_trap:
		ice = true
	else:
		ice = false
	
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
	var queued = 0
	
	for i in range(all_walls):
		var index = randi_range(0, 11)
		var real_wv = false
		var queued_walls = 0
		if i == real_wall:
			real_wv = true
		else:
			real_wv = false
		
		if not real_wv and max_walls > 1 and (randi_range(1,2) == 1):
			queued += 1
			queued_walls = queued
			
		var direction = directions[i]
		Walls(Wall_Variants[index], real_wv, direction, queued_walls)
	score += 1

func Walls(variant: GridMap, real: bool, direction, queued_walls):
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
		elif queued_walls >= 1:
			wall_animation.tween_interval(wall_speed*queued_walls)
			wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 15.5), wall_speed)
	if direction == 2:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 15.5), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed)
		elif queued_walls >= 1:
			wall_animation.tween_interval(wall_speed*queued_walls)
			wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed)
	if direction == 3:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(15.5, 0.5, 0), wall_speed)
		elif queued_walls >= 1:
			wall_animation.tween_interval(wall_speed*queued_walls)
			wall_animation.tween_property(duplicate_wall, "position", Vector3(15.5, 0.5, 0), wall_speed)
	if direction == 4:
		wall_animation.tween_property(duplicate_wall, "position", Vector3(0, 0.5, 0), wall_speed/3.0)
		wall_animation.tween_interval(2.0)
		if real:
			wall_animation.tween_property(duplicate_wall, "position", Vector3(-15.5, 0.5, 0), wall_speed)
		elif queued_walls >= 1:
			wall_animation.tween_interval(wall_speed*queued_walls)
			wall_animation.tween_property(duplicate_wall, "position", Vector3(-15.5, 0.5, 0), wall_speed)
	await wall_animation.finished
	duplicate_wall.queue_free()
	
	moving_walls -= 1
	if moving_walls <= 0:
		go_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var time
	Score.text = "Score: " + str(score)
	if timer_on:
		warning.visible = true
		time = int(timer.time_left)
		var seconds = time % 60
		var minutes = floori(time / 60)
		if seconds < 10:
			seconds = "0" + str(seconds)
		warning.text = str(minutes) +":"+ str(seconds)
		if time < trap_start_time and not traps_on:
			traps_on = true
			Traps()
			

	
	if not player_perspective.dead and Player_Camera.global_position.y > -12 and time == 0:
		won = true
		snap_floor.emit()
		if won:
			timer_on = false
			warning.text = "Level Completed"
			warning.visible = true
			await get_tree().create_timer(5.0, false).timeout
			var fade_out = create_tween()
			fade_out.tween_property($"Player/Player_Camera/CanvasLayer/Black Fade", "modulate:a", 1.0, 1)
			await fade_out.finished
			await get_tree().create_timer(0.5, false).timeout
			config.load(config_path)
			var levels_completed = config.get_value("LEVEL OPTIONS", "levels_completed", [])
			level = config.get_value("LEVEL OPTIONS", "level", 1)
			if level not in levels_completed:
				levels_completed.append(level)
			config.set_value("LEVEL OPTIONS", "levels_completed", levels_completed)
			config.save(config_path)
			won = false
			get_tree().change_scene_to_file("res://title_screen.tscn")
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
			
		
