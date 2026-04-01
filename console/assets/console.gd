extends CanvasLayer

#region Component Variables
@onready var console_window : Window = $"Console Window"
@onready var console_text : RichTextLabel = $"Console Window/MarginContainer/Control/Console BG/ScrollContainer/MarginContainer/Console Text"
@onready var line_edit : LineEdit = $"Console Window/MarginContainer/Control/HBoxContainer/LineEdit"

@onready var screen_text_message_container : VBoxContainer = $Control/MarginContainer/VBoxContainer
@export var screen_text_message_label_scene : PackedScene
#endregion

var open : bool = false

var default_console_window_size : Vector2
@export var default_console_font_size : int = 16
var u_text : String # The text from the user (line_edit.text)
@export var room_scenes_path : String = "res://scenes/rooms/"

var commands : Array[Command]
var active_command : Command
@export var spawnable_objects: Array[PackedScene]
var user_font_size : int = 11

#region Easter Egg Variables
@export var comic_sans : Font
@onready var haj_window : Window = $Haj
#endregion


func _ready() -> void:
	u_text = line_edit.text
	default_console_window_size = console_window.size
	_close_console()
	start_console()
	_add_all_commands()


func _add_all_commands():
	var dir := DirAccess.open("res://console/commands")
	if dir == null: printerr("Could not open folder"); return
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var resource := load(dir.get_current_dir() + "/" + file)
		commands.append(resource)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("console_open"):
		_open_console()
	
	if Input.is_action_just_pressed("console_close"):
		_close_console()
	
	if Input.is_action_just_pressed("console_enter"):
		_submit_to_console()


#region Common Console Functions
func start_console():
	await get_tree().create_timer(0.1).timeout
	console_window.position = Vector2(12, 36)
	console_text.add_theme_font_size_override("normal_font_size", default_console_font_size)
	user_font_size = default_console_font_size
	console_window.size = default_console_window_size
	console_text.text = ""
	print_welcome_message()


func _open_console():
	console_window.visible = true
	open = true
	line_edit.edit()


func _close_console():
	console_window.visible = false
	open = false


func _submit_to_console():
	u_text = line_edit.text
	if _check_commands():
		if not u_text.begins_with("clear"):
			if not u_text == "":
				print_to_console("[color=green]>> User: [/color]" + "[color=cyan]" + u_text + "[/color]", 0)
	elif u_text == "":
				print_error_to_console("Type something in the Console.", 0)
	else:
				print_error_to_console(u_text + " is not a valid command!", 0)
	line_edit.clear()
	line_edit.edit()


func print_to_console(_message : String, _delay : float):
	await get_tree().create_timer(_delay).timeout
	console_text.text += _message + "\n"


func print_to_screen(_message : String, _delay : float, _delete_delay : float):
	await get_tree().create_timer(_delay).timeout
	
	if screen_text_message_container.get_child_count() > 0:
		screen_text_message_container.remove_child(screen_text_message_container.get_child(0))
	
	var _sm = screen_text_message_label_scene.instantiate()
	screen_text_message_container.add_child(_sm)
	_sm.text = _message
	
	await get_tree().create_timer(_delete_delay).timeout
	_sm.queue_free()


func print_error_to_console(_message : String, _delay : float):
	print_to_console("[color=red]" + _message + "[/color]", _delay)


func _create_line():
	return "---------------------------------------------------------------------------------------------------"


func _get_name_from_path(_path):
	var path = _path.get_path()
	return str(path.right(-path.rfind("/") - 1).left(-5))
#endregion


#region Check Commands
func _check_commands():
	for c : Command in commands:
		if c.function_to_trigger != "":
			if u_text.begins_with(c.name):
				active_command = c
				call(c.function_to_trigger)
				return true
		else:
			printerr("No function to trigger from command. Please insert a Function to Trigger in your command")
	
	#TODO look at this stuff later
	#region Old Commands that still need to be reworked.
	##region A Discolored World Specific Commands
		##elif _command_to_explain == "set language":
			##print_to_console("
##[color=cyan]set language[/color]: Sets the language to what you typed in the console.
##As an example you could type: [color=cyan]set language italian[/color] and that would change the language to Italian.
##You can also type the language name in that language. 
##as an example you could type: [color=cyan]set language italiano[/color] and that would also change it to Italian.
##\n" + _create_line(), 0.1)
			##
		##elif _command_to_explain == "languages":
			##print_to_console("[color=cyan]languages[/color]: Gives a list of every language supported.\n" + _create_line(), 0.1)
	##endregion
	#
	##region Language Commands
		##elif _text.begins_with("languages"):
		##print_to_console("
##Here is a list of supported languages:
##English,
##Dutch / Nederlands,
##German / Deutsch
##French / Français
##Spanish / Español
##Italian / Italiano
##Portuguese / Português
##Danish / Dansk
##Swedish / Svenska
##Finnish / Suomalainen
##Czech / čeština
##Chinese / 國語
		##", 0.1)
		##return true
		#
	##elif _text.begins_with("set language"):
		##if _text.ends_with("english") or _text.ends_with("English"):
			##globals.set_language("english")
			##
		##elif _text.ends_with("dutch") or _text.ends_with("Dutch") or _text.ends_with("nederlands") or _text.ends_with("Nederlands"):
			##globals.set_language("dutch")
			##
		##elif _text.ends_with("german") or _text.ends_with("German") or _text.ends_with("deutsch") or _text.ends_with("Deutsch"):
			##globals.set_language("german")
		##
		##elif _text.ends_with("french") or _text.ends_with("French") or _text.ends_with("français") or _text.ends_with("Français"):
			##globals.set_language("french") 
		##
		##elif _text.ends_with("spanish") or _text.ends_with("Spanish") or _text.ends_with("español") or _text.ends_with("Español"):
			##globals.set_language("spanish")
		##
		##elif _text.ends_with("italian") or _text.ends_with("Italian") or _text.ends_with("italiano") or _text.ends_with("Italiano"):
			##globals.set_language("italian")
		##
		##elif _text.ends_with("portuguese") or _text.ends_with("portugese") or _text.ends_with("Portuguese") or _text.ends_with("português") or _text.ends_with("Português"):
			##globals.set_language("portugese")
			##
		##elif _text.ends_with("danish") or _text.ends_with("Danish") or _text.ends_with("dansk") or _text.ends_with("Dansk"):
			##globals.set_language("danish")
		##
		##elif _text.ends_with("swedish") or _text.ends_with("Swedish") or _text.ends_with("svenska") or _text.ends_with("Svenska"):
			##globals.set_language("swedish")
		##
		##elif _text.ends_with("finnish") or _text.ends_with("Finnish") or _text.ends_with("suomalainen") or _text.ends_with("Suomalainen"):
			##globals.set_language("finnish")
		##
		##elif _text.ends_with("czech") or _text.ends_with("Czech") or _text.ends_with("čeština") or _text.ends_with("cestina"):
			##globals.set_language("czech")
		##
		##elif _text.ends_with("chinese") or _text.ends_with("Chinese") or _text.ends_with("國語"):
			##globals.set_language("chinese")
		##
		### Easter egg languages
		##elif _text.ends_with("minionese") or _text.ends_with("Minionese") or _text.ends_with("minion") or _text.ends_with("minion language"):
			##globals.set_language("minionese")
		##
		##print_to_console("App language is set to: " + globals.language, 0.1)
		##
		##return true
	##endregion
	
	##elif _text == "minion" or _text == "minionese":
		##globals.set_language("minionese")
		##print_to_console("App language is set to: " + globals.language, 0.1)
		##return true
	#endregion
#endregion


#region Command Functions
func clear():
	console_text.text = ""


func change_scene():
	var _new_scene
	_new_scene = room_scenes_path + line_edit.text.replace("cs ", "") + ".tscn"
	
	if ResourceLoader.exists(_new_scene):
		get_tree().change_scene_to_file(_new_scene)
		print_to_console("Loaded scene: " + str(_new_scene) , 0.1)
	else:
		print_error_to_console("Could not load scene: " + str(_new_scene), 0.1)


func set_font_size():
	if u_text.contains("default"):
		console_text.add_theme_font_size_override("normal_font_size", 11)
		user_font_size = 11
		print_to_console("Font size changed to default (11) ", 0.1)
	else:
		var _font_size : int = u_text.replace("font size", "").to_int()
		console_text.add_theme_font_size_override("normal_font_size", _font_size)
		user_font_size = _font_size
		print_to_console("Font size changed to: " + str(_font_size), 0.1)


func restart_scene():
	get_tree().reload_current_scene()


func explain():
	var _command_to_explain : String = u_text.replace("explain ", "")
	var _found_command = false
	
	for c in commands:
		if c.name == _command_to_explain and u_text != "explain":
			print_to_console(c.detailed_explaination, 0.1)
			_found_command = true
	
	if not _found_command:
		print_to_console("Please enter a command to explain. To look at all commands in the console, use the command: [color=cyan]commands[/color].", 0.1)


func spawn_scene():
	var _object_to_spawn = u_text.replace("spawn ", "")
	print_to_console("Spawned: [color=yellow]" + str(_object_to_spawn) + "[/color]", 0.1)


#region Print Messages
func print_as_user():
	print_to_console(u_text.replace("print ", ""), 0.1)


func print_to_screen_as_user():
	print_to_screen(u_text.replace("prints ", ""), 0.1, 5)


func print_hello_world():
	print_to_console("[font_size=32]Hello World![/font_size]", 0.1)
	print_to_console(_create_line(), 0.2)


func print_spawnable_scenes():
	print_to_console(_create_line() + "\n[font_size=32]All spawnable objects:[/font_size]", 0.1)
	for i in spawnable_objects.size():
		print_to_console(_get_name_from_path(spawnable_objects[i]), i * 0.1 + 0.1)


func print_help_message():
	print_to_console(_create_line() + "
[font_size=32]Help:[/font_size]
Press [color=yellow]ESC[/color] to exit the Console
[color=cyan]commands[/color]: Shows all Console commands*
[color=cyan]clear[/color]: Clears the Console
[color=cyan]print[/color]: Prints something to the Console
[color=cyan]explain[/color]: Explains the command you put after it.
" + _create_line(), 0.1)


func print_welcome_message():
	print_to_console(_create_line() + "
[font_size=32]Welcome to the Console![/font_size]
To get started use the command:
[color=cyan]help[/color] to show some useful commands.\n" + _create_line(), 0.1)


func print_all_commands():
	print_to_console(_create_line() + "\n[font_size=32]All commands:[/font_size]", 0.1)
	var i : float = 0
	
	for c : Command in commands:
		
		if not c.easter_egg:
			i += 0.1
			print_to_console("[color=cyan]" + c.name + "[/color]: " + c.description, i)
		
		if c == commands.get(commands.size() -1):
			print_to_console(_create_line(), i)
	
#endregion


#region Game Specific Commands (All commands for your specific project. These are commented out lines from the game I'm working on. You can delete them if you want, or keep them if you want.
func noclip_player():
	print_to_console("This is a game / project specific command. If you'd like to change it to work with your game, then change this function. You can look at the commented lines of code for my game as a reference, and tweak it to work with your game.", 0.1)
	#var _player = get_tree().get_first_node_in_group("player")
	#var _player_state_machine : StateMachine = get_tree().get_first_node_in_group("player").get_child(0)
	#
	#if not globals.noclip:
		#globals.noclip = true
		#_player_state_machine.current_state.transitioned.emit(_player_state_machine.current_state, "playernoclip")
		#print_to_console("noclip [color=green]enabled[/color].", 0.1)
		#print_to_screen("noclip [color=green]enabled[/color].", 0.1, 5.1)
	#else:
		#globals.noclip = false
		#_player_state_machine.current_state.transitioned.emit(_player_state_machine.current_state, "playeridle")
		#_player.enable_movement.emit()
		#print_to_console("noclip [color=red]disabled[/color].", 0.1)
		#print_to_screen("noclip [color=red]disabled[/color].", 0.1, 5.1)
#endregion


#region Easter Eggs
func haj():
	print_to_console("click the x to close", 0.1)
	haj_window.visible = true


func markiplier():
	print_to_console("ohohohoho youre so Portuguese", 0.1)
	#globals.set_language("portugese")
	print_to_console("Portuguese", 2)
	print_to_console(" [img=height=112]res://console/mark.jpeg[/img]\n" + _create_line(), 3.2)


func sans_console():
	console_text.add_theme_font_override("normal_font", comic_sans)
	console_text.add_theme_font_size_override("normal_font_size", 10)
	print_to_console("I HAVE SANSED YOUR CONSOLE, TYPE: [color=yellow]UNSANS[/color] TO UNSANS YOUR SANSED CONSOLE", 0.1)


func unsans_console():
	if console_text.has_theme_font_override("normal_font"):
		print_to_console("I HAVE UNSANSED YOUR CONSOLE", 0.1)
		console_text.remove_theme_font_override("normal_font")
		console_text.add_theme_font_size_override("normal_font_size", user_font_size)
		print_to_console("It seems like the console has turned back to normal...", 1.1)
#endregion

#endregion

func _on_console_text_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)
