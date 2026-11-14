extends Camera3D

@onready var Player = $".."
@onready var fps = $CanvasLayer/GUI/FPS
@onready var Collision_Shape = $"../CollisionShape3D"
@onready var Sea: MeshInstance3D = $"../../Sea/MeshInstance3D"
@onready var Sun = $"../../Sun"
@onready var game_sky = $"../../WorldEnvironment"

var config = ConfigFile.new()
var config_path = "user://Config.cfg"
var sensitivity: float = 0.2
var options
var crouching: bool = false
var sliding: bool = false
var crouch_tween: Tween
var camera_y: float
var animated_sea = preload("res://textures/animated_sea.tres")
var sea = preload("res://textures/non_animated_sea.tres")
var cloud_sky = preload("res://textures/sky.tres")
var saved_sky
var Realistic_Texture = preload("res://textures/Realistic Map Designer.meshlib")
var Default = preload("res://textures/Map Designer.meshlib")
var walls

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera_y = self.position.y
	saved_sky = cloud_sky
	walls = get_tree().get_nodes_in_group("Walls")
	update()
	
	
func update():
	config.load(config_path)
	var animated = config.get_value("GRAPHICS", "animated_sea", true)
	if Sea:
		if animated == true:
			Sea.material_override = animated_sea
		else:
			Sea.material_override = sea
	
	var shadows = config.get_value("GRAPHICS", "shadows", true)
	if Sun:
		if shadows == true:
			Sun.shadow_enabled = true
		else:
			Sun.shadow_enabled = false
	
	var show_sun = config.get_value("GRAPHICS", "show_sun", true)
	if Sun:
		if show_sun == true:
			Sun.visible = true
		else:
			Sun.visible = false
	
	var show_sky = config.get_value("GRAPHICS", "show_sky", true)
	if game_sky:
		if show_sky == true:
			game_sky.environment.sky = saved_sky
		else:
			game_sky.environment.sky = null
	
	var show_sea = config.get_value("GRAPHICS", "show_sea", true)
	if Sea:
		if show_sea == true:
			Sea.visible = true
		else:
			Sea.visible = false
	
	var better_reflections = config.get_value("GRAPHICS", "better_reflections", true)
	if game_sky:
		if better_reflections == true:
			game_sky.environment.glow_enabled = true
		else:
			game_sky.environment.glow_enabled = false
	
	var show_fog = config.get_value("GRAPHICS", "show_fog", true)
	if game_sky:
		if show_fog == true:
			game_sky.environment.fog_enabled = true
		else:
			game_sky.environment.fog_enabled = false
	
	var sun_strength = config.get_value("GRAPHICS", "sun_strength", true)
	if Sun:
		if 4.0 <= sun_strength and sun_strength <= 16.0:
			Sun.light_energy = sun_strength
	print("sun energy: "+str(Sun.light_energy)+" setting energy: "+str(sun_strength))
	
	sensitivity = config.get_value("INPUTS", "sensitivity", 0.2)
	3
	var wall_texture = config.get_value("GRAPHICS", "wall_texture")
	if wall_texture != null:
		if wall_texture == 0:
			for i in walls:
				i.mesh_library = null
				i.mesh_library = Realistic_Texture
				print("Real "+str(i.mesh_library.resource_path))
		elif wall_texture == 1:
			for i in walls:
				i.mesh_library = Default
				print("Default "+str(i.mesh_library.resource_path))

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("crouch") and not crouching:
		Collision_Shape.shape.size = Vector3(0.5, 1.4, 0.5)
		if crouch_tween:
			crouch_tween.kill()
		
		crouch_tween = create_tween()
		crouch_tween.set_ease(crouch_tween.EASE_OUT)
		crouch_tween.tween_property(self, "position:y", camera_y - 0.5, 0.3)
		crouching = true
	
	elif Input.is_action_just_released("crouch") and crouching:
		Collision_Shape.shape.size = Vector3(0.5, 1.8, 0.5)
		if crouch_tween:
			crouch_tween.kill()
		
		crouch_tween = create_tween()
		crouch_tween.set_ease(crouch_tween.EASE_IN)
		crouch_tween.tween_property(self, "position:y", camera_y, 0.3)
		crouching = false
	
	if Input.is_action_just_pressed("slide") and not sliding:
		Collision_Shape.shape.size = Vector3(0.5, 1.4, 0.5)
		if crouch_tween:
			crouch_tween.kill()
		
		crouch_tween = create_tween()
		crouch_tween.set_ease(crouch_tween.EASE_OUT)
		crouch_tween.tween_property(self, "position:y", camera_y - 0.5, 0.3)
		sliding = true
		
		await get_tree().create_timer(0.65).timeout
		
		Collision_Shape.shape.size = Vector3(0.5, 1.8, 0.5)
		if crouch_tween:
			crouch_tween.kill()
		
		crouch_tween = create_tween()
		crouch_tween.set_ease(crouch_tween.EASE_IN)
		crouch_tween.tween_property(self, "position:y", camera_y, 0.3)
		sliding = false


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Player.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
	
	if self.global_position.y < 0:
		pass
