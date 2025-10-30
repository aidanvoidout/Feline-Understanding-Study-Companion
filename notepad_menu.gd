class_name NotepadMenu extends Window

@onready var notepad_text: TextEdit = $VBoxContainer/NotepadText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_requested() -> void:
	visible = false
	
