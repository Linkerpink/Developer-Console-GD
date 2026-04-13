extends VBoxContainer

var selected_node : Control
var selected : int
@onready var console_window : Window = $"../Console Window"
@onready var before_scroll_timer : Timer = %BeforeScrollTimer
@onready var scroll_timer : Timer = %ScrollTimer
@onready var line_edit : LineEdit = $"../Console Window/MarginContainer/Control/HBoxContainer/LineEdit"

enum ScrollDirections{
	Up,
	Down
}

var scroll_direction : ScrollDirections


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		select(selected - 1)
		scroll_direction = ScrollDirections.Up
		before_scroll_timer.start()
		scroll_timer.stop()
	
	if Input.is_action_just_pressed("ui_down"):
		select(selected + 1)
		scroll_direction = ScrollDirections.Down
		before_scroll_timer.start()
		scroll_timer.stop()
	
	if Input.is_anything_pressed():
		if get_child_count() == 1:
			select(0)
		
		if selected == 0:
			select(0)
	
	if Input.is_action_just_pressed("ui_text_indent") and console_window.visible:
		select(0)
	
	position = Vector2(console_window.position.x + 28, console_window.position.y + console_window.size.y + 8)
	
	if get_child_count() <= 0:
		selected = -1
	else:
		if selected == -1:
			select(0)


func select(_selection : int):
	if get_child_count() > 0:
		if _selection < 0:
			_selection = get_child_count() - 1
		
		if _selection > get_child_count() - 1:
			_selection = 0
		
		#_selection = clamp(_selection, 0, get_child_count())
		
		selected = _selection
		selected_node = get_children()[_selection]
		
		for c in get_children():
			c.find_child("Label").self_modulate = Color(0.588, 0.588, 0.588, 1.0)
		
		selected_node.find_child("Label").self_modulate = Color(1.0, 1.0, 1.0, 1.0)


func _on_before_scroll_timer_timeout() -> void:
	_scroll_in_direction()


func _scroll_in_direction():
	if scroll_direction == ScrollDirections.Up:
		if Input.is_action_pressed("ui_up"):
			select(selected - 1)
			scroll_timer.start()
	
	if scroll_direction == ScrollDirections.Down:
		if Input.is_action_pressed("ui_down"):
			select(selected + 1)
			scroll_timer.start()
