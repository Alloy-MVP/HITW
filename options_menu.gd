extends Control

@onready var ui = $CanvasLayer
@onready var sensitivity_label = $CanvasLayer/TabContainer/Mouse/Sensitivity/Label2
@onready var forward_input_label = $CanvasLayer/TabContainer/Mouse/Forward/Button

var sensitivity
var selected: bool = false
var forward

signal options_update

var config = ConfigFile.new()
var config_path = "user://Config.cfg"
var master_config_path = "res://Config.cfg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.visible = false
	self.visible = false
	
	if not FileAccess.file_exists(config_path):
		DirAccess.copy_absolute(master_config_path, config_path)
	load_config()

func load_config():
	config.load(config_path)
	
	sensitivity = config.get_value("INPUTS", "sensitivity")
	sensitivity_label.text = str(int(sensitivity*100)) + "%"
	forward = config.get_value("INPUTS", "forward")
	forward_input_label.text = str(forward)
	$CanvasLayer/TabContainer/Mouse/Sensitivity/HSlider.set_value_no_signal(sensitivity)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if selected:
			forward = event.as_text()
			forward_input_label.release_focus()
			forward_input_label.text = forward
			selected = false
		

func Hide():
	ui.visible = false
	
func Show():
	load_config()
	ui.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	var pause_menu_exists = get_tree().get_first_node_in_group("Pause")
	if pause_menu_exists and pause_menu_exists.paused:
		get_tree().get_first_node_in_group("Pause").back()
	else:
		get_tree().get_first_node_in_group("Title Screen").back()





func sensitivity_changed(value: float) -> void:
	sensitivity = value
	if sensitivity:
		var s = str(int(value*100))
		sensitivity_label.text = s + "%"

func forwards_selected() -> void:
	selected = true
	var b = config.get_value("INPUTS", "forward")
	if selected:
		forward_input_label.grab_focus()
		forward_input_label.text = ">Press any key<"


func _on_save_pressed() -> void:
	if sensitivity != null:
		config.set_value("INPUTS", "sensitivity", sensitivity)
	if forward != null:
		config.set_value("INPUTS", "forward", forward)
		InputMap.action_erase_events("forward")
		var new_forward = InputEventKey.new()
		new_forward.keycode = OS.find_keycode_from_string(forward)
		InputMap.action_add_event("forward", new_forward)
	
	config.save(config_path)
	
	emit_signal("options_update")
