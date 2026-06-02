class_name AetherKiriPlayer
extends Node

func debug_gpu_blend2_self_test(): pass
func debug_gpu_blend_self_test(): pass
func destroy_engine(): pass
func drain_startup_logs(): return []
func get_frame_texture_backend(): return ""
func get_last_error(): return ""
func get_last_result(): return 0
func get_renderer_info(): return ""
func get_startup_state(): return 0
func initialize_engine(user_dir, cache_dir): return false
func open_game(game_path, b): return 0
func read_frame_rgba(): return PackedByteArray()
func release_frame_texture(): pass
func send_key_event(pressed, key_code, modifiers, unicode): pass
func send_pointer_event(event_type, pointer_id, x, y, dx, dy, modifiers): pass
func set_engine_option(key, value): pass
func set_render_backend(backend): pass
func set_surface_size(width, height): pass
func tick(delta): return 0
func update_frame_texture(): return null
