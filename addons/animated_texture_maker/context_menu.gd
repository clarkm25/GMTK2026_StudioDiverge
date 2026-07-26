@tool
extends EditorContextMenuPlugin

func _popup_menu(paths: PackedStringArray) -> void:
	var textures := _filter_textures(paths)
	if textures.size() < 2:
		return

	add_context_menu_item("Make AnimatedTexture", _make_animated_texture)

func _filter_textures(paths: PackedStringArray) -> Array[String]:
	var textures: Array[String] = []
	for path in paths:
		var ext := path.get_extension().to_lower()
		if ext in ["png", "jpg", "jpeg", "webp", "svg", "bmp", "tga", "exr", "hdr", "dds", "ktx", "ktx2"]:
			textures.append(path)
	return textures

func _make_animated_texture(paths: Array) -> void:
	var textures := _filter_textures(paths)
	textures.sort()

	var anim_tex := AnimatedTexture.new()
	anim_tex.frames = textures.size()

	for i in range(textures.size()):
		var tex: Texture2D = load(textures[i])
		anim_tex.set_frame_texture(i, tex)

	var dir := textures[0].get_base_dir()
	var base_name := textures[0].get_file().get_basename()
	var save_path := dir.path_join(base_name + ".tres")

	var i := 1
	while FileAccess.file_exists(save_path):
		save_path = dir.path_join("%s_%d.tres" % [base_name, i])
		i += 1

	var err := ResourceSaver.save(anim_tex, save_path)
	if err == OK:
		print("Saved AnimatedTexture to: ", save_path)
		EditorInterface.get_resource_filesystem().scan()
	else:
		push_error("Failed to save AnimatedTexture: %s" % err)
