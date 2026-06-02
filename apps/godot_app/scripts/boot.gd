extends Control

@onready var label = $ColorRect/Label
@onready var timer = $Timer

func _ready():
    # Wait a frame to ensure drawing
    timer.start(0.5)

func _on_timer_timeout():
    # Attempt to load the main scene
    var main_res = ResourceLoader.load("res://scenes/main.tscn")
    if main_res != null:
        var main_node = main_res.instantiate()
        if main_node != null:
            get_tree().root.add_child(main_node)
            queue_free()
            return
    
    # If we are here, it failed.
    _show_error()

func _show_error():
    var err_text = "CRITICAL BOOT ERROR\nFailed to load 'res://scenes/main.tscn' or instantiate it.\nThis usually means the native GDExtension (AetherKiriPlayer) failed to load.\n\n--- GODOT LOG ---\n"
    
    var log_file = FileAccess.open("user://logs/godot.log", FileAccess.READ)
    if log_file != null:
        err_text += log_file.get_as_text()
        log_file.close()
    else:
        err_text += "[Godot log file not found at user://logs/godot.log]"
    
    label.text = err_text
