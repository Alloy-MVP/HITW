extends Control

@onready var ui = $CanvasLayer
@onready var sensitivity_label = $CanvasLayer/TabContainer/Inputs/Sensitivity/Label2
@onready var forward_input_label = $CanvasLayer/TabContainer/Inputs/Forward/Button
@onready var backward_input_label = $CanvasLayer/TabContainer/Inputs/Backward/Button
@onready var left_input_label = $CanvasLayer/TabContainer/Inputs/Left/Button
@onready var right_input_label = $CanvasLayer/TabContainer/Inputs/Right/Button
@onready var jump_input_label = $CanvasLayer/TabContainer/Inputs/Jump/Button
@onready var crouch_input_label = $CanvasLayer/TabContainer/Inputs/Crouch/Button
@onready var slide_input_label = $CanvasLayer/TabContainer/Inputs/Slide/Button

@onready var animated_sea_checkbox = $"CanvasLayer/TabContainer/Graphics/Animated Sea/Animated Sea"
@onready var shadows_checkbox = $CanvasLayer/TabContainer/Graphics/Shadows/Shadows
@onready var show_sun_checkbox = $"CanvasLayer/TabContainer/Graphics/Show Sun/CheckButton"
@onready var show_sky_checkbox = $"CanvasLayer/TabContainer/Graphics/Show Sky/CheckButton"
@onready var show_sea_checkbox = $"CanvasLayer/TabContainer/Graphics/Show Sea/CheckButton"
@onready var better_reflections_checkbox = $"CanvasLayer/TabContainer/Graphics/Better Sun Refs/CheckButton"
@onready var show_fog_checkbox = $"CanvasLayer/TabContainer/Graphics/Show Fog/CheckButton"
@onready var sun_strength_label = $"CanvasLayer/TabContainer/Graphics/Sun Strength/Label2"
@onready var wall_texture_option = $"CanvasLayer/TabContainer/Graphics/Wall Texture/OptionButton"

var sensitivity
var forward
var backward
var left
var right
var jump
var crouch
var slide
var selected_keybind = ""
var animated_sea: bool
var shadows: bool
var show_sun: bool
var show_sky: bool
var show_sea: bool
var better_reflections: bool
var show_fog: bool
var sun_strength
var wall_texture

signal options_update

var config = ConfigFile.new()
var config_path = "user://Config.cfg"
var master_config_path = "res://Config.cfg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not FileAccess.file_exists(config_path):
		DirAccess.copy_absolute(master_config_path, config_path)
	sensitivity_label.text = "20%"
	forward_input_label.text = "W"
	backward_input_label.text = "S"
	left_input_label.text = "A"
	backward_input_label.text = "D"
	jump_input_label.text = "SPACE"
	crouch_input_label.text = "SHIFT"
	slide_input_label.text = "M"
	load_config()

func load_config():
	config.load(config_path)
	sensitivity = config.get_value("INPUTS", "sensitivity", 0.2)
	sensitivity_label.text = str(int(sensitivity*100)) + "%"
	forward = config.get_value("INPUTS", "forward", "W")
	forward_input_label.text = str(forward)
	backward = config.get_value("INPUTS", "backward", "S")
	backward_input_label.text = str(backward)
	left = config.get_value("INPUTS", "left", "A")
	left_input_label.text = str(left)
	right = config.get_value("INPUTS", "right", "D")
	right_input_label.text = str(right)
	jump = config.get_value("INPUTS", "jump", "SPACE")
	jump_input_label.text = str(jump)
	crouch = config.get_value("INPUTS", "crouch", "SHIFT")
	crouch_input_label.text = str(crouch)
	slide = config.get_value("INPUTS", "slide", "M")
	slide_input_label.text = str(slide)
	
	
	animated_sea = config.get_value("GRAPHICS", "animated_sea", true)
	animated_sea_checkbox.set_pressed_no_signal(animated_sea)
	shadows = config.get_value("GRAPHICS", "shadows", true)
	shadows_checkbox.set_pressed_no_signal(shadows)
	show_sun = config.get_value("GRAPHICS", "show_sun", true)
	show_sun_checkbox.set_pressed_no_signal(show_sun)
	show_sky = config.get_value("GRAPHICS", "show_sky", true)
	show_sky_checkbox.set_pressed_no_signal(show_sky)
	show_sea = config.get_value("GRAPHICS", "show_sea", true)
	show_sea_checkbox.set_pressed_no_signal(show_sea)
	better_reflections = config.get_value("GRAPHICS", "better_reflections", true)
	better_reflections_checkbox.set_pressed_no_signal(better_reflections)
	show_fog = config.get_value("GRAPHICS", "show_fog", true)
	show_fog_checkbox.set_pressed_no_signal(show_fog)
	sun_strength = config.get_value("GRAPHICS", "sun_strength", 16.0)
	sun_strength_label.text = str(int(((sun_strength-4)/12)*100)) + "%"
	wall_texture = config.get_value("GRAPHICS", "wall_texture")
	wall_texture_option.selected = wall_texture
	
	$"CanvasLayer/TabContainer/Graphics/Sun Strength/HSlider".value = sun_strength
	$CanvasLayer/TabContainer/Inputs/Sensitivity/HSlider.set_value_no_signal(sensitivity)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if selected_keybind != "":
			if selected_keybind == "forward":
				forward = event.as_text()
				forward_input_label.release_focus()
				forward_input_label.text = forward
				
			elif selected_keybind == "backward":
				backward = event.as_text()
				backward_input_label.release_focus()
				backward_input_label.text = backward
			
			elif selected_keybind == "left":
				left = event.as_text()
				left_input_label.release_focus()
				left_input_label.text = left
			
			elif selected_keybind == "right":
				right = event.as_text()
				right_input_label.release_focus()
				right_input_label.text = right
			
			elif selected_keybind == "jump":
				jump = event.as_text()
				jump_input_label.release_focus()
				jump_input_label.text = jump
			
			elif selected_keybind == "crouch":
				crouch = event.as_text()
				crouch_input_label.release_focus()
				crouch_input_label.text = crouch
			
			elif selected_keybind == "slide":
				slide = event.as_text()
				slide_input_label.release_focus()
				slide_input_label.text = slide

			selected_keybind = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	var pause_menu_exists = get_tree().get_first_node_in_group("Pause")
	if pause_menu_exists and pause_menu_exists.paused:
		pause_menu_exists.options_back()
	else:
		var title_screen = get_tree().get_first_node_in_group("Title Screen")
		if title_screen:
			title_screen.back()


# INPUTS
func sensitivity_changed(value: float) -> void:
	sensitivity = value
	if sensitivity:
		var s = str(int(value*100))
		sensitivity_label.text = s + "%"

func forwards_selected() -> void:
	selected_keybind = "forward"
	forward_input_label.grab_focus()
	forward_input_label.text = ">Press any key<"

func backwards_selected() -> void:
	selected_keybind = "backward"
	backward_input_label.grab_focus()
	backward_input_label.text = ">Press any key<"

func left_selected() -> void:
	selected_keybind = "left"
	left_input_label.grab_focus()
	left_input_label.text = ">Press any key<"

func right_selected() -> void:
	selected_keybind = "right"
	right_input_label.grab_focus()
	right_input_label.text = ">Press any key<"

func jump_selected() -> void:
	selected_keybind = "jump"
	jump_input_label.grab_focus()
	jump_input_label.text = ">Press any key<"

func crouch_selected() -> void:
	selected_keybind = "crouch"
	crouch_input_label.grab_focus()
	crouch_input_label.text = ">Press any key<"

func slide_selected() -> void:
	selected_keybind = "slide"
	slide_input_label.grab_focus()
	slide_input_label.text = ">Press any key<"

# GRAPHICS
func _on_animate_sea_toggled(toggled_on: bool) -> void:
	animated_sea = toggled_on
	var state
	if toggled_on:
		state = "checked"
	else:
		state = "unchecked"
	var animation = animated_sea_checkbox.get_theme_icon(state)
	
	if animation:
		animation.current_frame = 0
		animation.pause = false

func _on_shadows_toggled(toggled_on: bool) -> void:
	shadows = toggled_on
	var state
	if toggled_on:
		state = "checked"
	else:
		state = "unchecked"
	var animation = shadows_checkbox.get_theme_icon(state)
	
	if animation:
		animation.current_frame = 0
		animation.pause = false

func _on_show_sun_button_toggled(toggled_on: bool) -> void:
	show_sun = toggled_on
	var state
	if toggled_on:
		state = "checked"
	else:
		state = "unchecked"
	var animation = show_sun_checkbox.get_theme_icon(state)
	
	if animation:
		animation.current_frame = 0
		animation.pause = false

func _on_show_sky_button_toggled(toggled_on: bool) -> void:
	show_sky = toggled_on
	var state
	if toggled_on:
		state = "checked"
	else:
		state = "unchecked"
	var animation = show_sky_checkbox.get_theme_icon(state)
	
	if animation:
		animation.current_frame = 0
		animation.pause = false

func _on_show_sea_button_toggled(toggled_on: bool) -> void:
	show_sea = toggled_on
	var state
	if toggled_on:
		state = "checked"
	else:
		state = "unchecked"
	var animation = show_sea_checkbox.get_theme_icon(state)
	
	if animation:
		animation.current_frame = 0
		animation.pause = false

func _on_better_sun_refs_button_toggled(toggled_on: bool) -> void:
	better_reflections = toggled_on
	var state
	if toggled_on:
		state = "checked"
	else:
		state = "unchecked"
	var animation = better_reflections_checkbox.get_theme_icon(state)
	
	if animation:
		animation.current_frame = 0
		animation.pause = false

func _on_show_fog_button_toggled(toggled_on: bool) -> void:
	show_fog = toggled_on
	var state
	if toggled_on:
		state = "checked"
	else:
		state = "unchecked"
	var animation = show_fog_checkbox.get_theme_icon(state)
	
	if animation:
		animation.current_frame = 0
		animation.pause = false

func _on_sun_strength_value_changed(value: float) -> void:
	sun_strength = value
	if sun_strength:
		var ss = str(int(((sun_strength-4)/12)*100))
		sun_strength_label.text = ss + "%"

func _on_wall_texture_item_selected(index: int) -> void:
	wall_texture = index


func _on_save_pressed() -> void:
	config.set_value("INPUTS", "sensitivity", sensitivity)

	config.set_value("INPUTS", "forward", forward)
	InputMap.action_erase_events("forward")
	var new_forward = InputEventKey.new()
	new_forward.keycode = OS.find_keycode_from_string(forward)
	InputMap.action_add_event("forward", new_forward)

	config.set_value("INPUTS", "backward", backward)
	InputMap.action_erase_events("backward")
	var new_backward = InputEventKey.new()
	new_backward.keycode = OS.find_keycode_from_string(backward)
	InputMap.action_add_event("backward", new_backward)
	
	config.set_value("INPUTS", "left", left)
	InputMap.action_erase_events("left")
	var new_left = InputEventKey.new()
	new_left.keycode = OS.find_keycode_from_string(left)
	InputMap.action_add_event("left", new_left)
	
	config.set_value("INPUTS", "right", right)
	InputMap.action_erase_events("right")
	var new_right = InputEventKey.new()
	new_right.keycode = OS.find_keycode_from_string(right)
	InputMap.action_add_event("right", new_right)
	
	config.set_value("INPUTS", "jump", jump)
	InputMap.action_erase_events("jump")
	var new_jump = InputEventKey.new()
	new_jump.keycode = OS.find_keycode_from_string(jump)
	InputMap.action_add_event("jump", new_jump)
	
	config.set_value("INPUTS", "crouch", crouch)
	InputMap.action_erase_events("crouch")
	var new_crouch = InputEventKey.new()
	new_crouch.keycode = OS.find_keycode_from_string(crouch)
	InputMap.action_add_event("crouch", new_crouch)
	
	config.set_value("INPUTS", "slide", slide)
	InputMap.action_erase_events("slide")
	var new_slide = InputEventKey.new()
	new_slide.keycode = OS.find_keycode_from_string(slide)
	InputMap.action_add_event("slide", new_slide)
	
	
	config.set_value("GRAPHICS", "animated_sea", animated_sea)
	
	config.set_value("GRAPHICS", "shadows", shadows)
	
	config.set_value("GRAPHICS", "show_sun", show_sun)
	
	config.set_value("GRAPHICS", "show_sky", show_sky)
	
	config.set_value("GRAPHICS", "show_sea", show_sea)
	
	config.set_value("GRAPHICS", "better_reflections", better_reflections)
	
	config.set_value("GRAPHICS", "show_fog", show_fog)
	
	config.set_value("GRAPHICS", "sun_strength", sun_strength)
	
	config.set_value("GRAPHICS", "wall_texture", wall_texture)
	
	config.save(config_path)
	
	$"CanvasLayer/Options Saved".text = "Options saved"
	emit_signal("options_update")
