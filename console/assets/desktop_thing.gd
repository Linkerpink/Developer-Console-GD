extends Window

func _ready():
	visible = false


func _on_close_requested() -> void:
	visible = false
