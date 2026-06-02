extends Control

@onready var label = $ColorRect/Label
var log_file: FileAccess = null
var main_loaded := false

func _ready():
    label.text = "Booting AetherKiri...\n"
    
    var copy_btn = Button.new()
    copy_btn.text = "COPY LOG TO CLIPBOARD"
    copy_btn.position = Vector2(50, 50)
    copy_btn.size = Vector2(400, 100)
    copy_btn.add_theme_font_size_override("font_size", 30)
    copy_btn.pressed.connect(func(): DisplayServer.clipboard_set(label.text))
    add_child(copy_btn)
    
    # Start loading in background to not block the main thread
    ResourceLoader.load_threaded_request("res://scenes/main.tscn")

func _process(delta: float):
    # Continuously read Godot log if available
    if log_file == null:
        if FileAccess.file_exists("user://logs/godot.log"):
            log_file = FileAccess.open("user://logs/godot.log", FileAccess.READ)
    
    if log_file != null:
        var new_text := log_file.get_as_text()
        if new_text.length() > 0:
            label.text += new_text
    
    if not main_loaded:
        var status = ResourceLoader.load_threaded_get_status("res://scenes/main.tscn")
        if status == ResourceLoader.THREAD_LOAD_LOADED:
            var main_res = ResourceLoader.load_threaded_get("res://scenes/main.tscn")
            var main_node = main_res.instantiate()
            if main_node.get_script() == null:
                main_loaded = true
                label.text += "\n\n[CRITICAL] main.gd failed to compile/attach! Native extension probably failed to load."
            else:
                main_loaded = true
                get_tree().root.add_child(main_node)
                queue_free()
        elif status == ResourceLoader.THREAD_LOAD_FAILED or status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
            main_loaded = true
            label.text += "\n\n[CRITICAL] Failed to load main.tscn! Native extension probably failed to load."

