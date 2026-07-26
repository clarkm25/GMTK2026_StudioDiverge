@tool
extends EditorPlugin

var context_menu: EditorContextMenuPlugin

func _enter_tree() -> void:
	context_menu = preload("res://addons/animated_texture_maker/context_menu.gd").new()
	add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_FILESYSTEM, context_menu)

func _exit_tree() -> void:
	remove_context_menu_plugin(context_menu)
