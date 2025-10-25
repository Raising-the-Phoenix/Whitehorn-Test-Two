extends CanvasLayer

@export var cursor_texture: Texture2D
@export var ibeam_texture: Texture2D
@export var highlight_texture: Texture2D
@export var tile_size: int = 32

# --- Nodes ---
@onready var sprite: TextureRect = $Container/CursorSprite
@onready var tile_highlight: TextureRect = $TileHighlight

# --- TileMap highlighting ---
var tilemap_layer: TileMapLayer = null

# --- Cursor state ---
var is_ibeam: bool = false

# --- Recursive search for TileMapLayer ---
func _find_tilemap(node: Node) -> TileMapLayer:
	if node is TileMapLayer:
		return node
	for child in node.get_children():
		if child != null:
			var found = _find_tilemap(child)
			if found != null:
				return found
	return null

# --- Switch cursor textures ---
func _set_cursor_to_ibeam():
	if ibeam_texture:
		sprite.texture = ibeam_texture
	is_ibeam = true

func _set_cursor_to_normal():
	if cursor_texture:
		sprite.texture = cursor_texture
	is_ibeam = false

# --- Highlight tile under mouse ---
func _highlight_tile_under_cursor(mouse_pos: Vector2) -> void:
	if tilemap_layer == null:
		return

	var local_pos = tilemap_layer.to_local(mouse_pos)
	var cell = tilemap_layer.local_to_map(local_pos)
	var tile_pos = tilemap_layer.map_to_local(cell)

	tile_highlight.global_position = tilemap_layer.to_global(tile_pos).snapped(Vector2(tile_size, tile_size))

# --- Godot lifecycle ---
func _ready() -> void:
	# Always on top
	layer = 1025  # high number to draw above popups	

	# Hide system cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	sprite.mouse_filter = Control.MOUSE_FILTER_IGNORE # ignore this when detecting mouse clicks; clicks pass through cursor to UI
	tile_highlight.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Initialize textures
	if cursor_texture:
		sprite.texture = cursor_texture
	if highlight_texture:
		tile_highlight.texture = highlight_texture

	sprite.visible = true
	tile_highlight.visible = true

# --- Hide system cursor when mouse re-enters ---
func _notification(what):
	if what == NOTIFICATION_WM_MOUSE_ENTER or what == NOTIFICATION_APPLICATION_FOCUS_IN:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# --- Main process ---
func _process(_delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	sprite.global_position = mouse_pos

	# Switch cursor if hovering a text input
	var hovered = get_viewport().gui_get_hovered_control()
	if hovered != null and (hovered is LineEdit or hovered is TextEdit):
		if not is_ibeam:
			_set_cursor_to_ibeam()
	else:
		if is_ibeam:
			_set_cursor_to_normal()

	# Tile highlighting
	if tilemap_layer == null:
		var scene = get_tree().current_scene
		if scene != null:
			tilemap_layer = _find_tilemap(scene)

	if tilemap_layer:
		_highlight_tile_under_cursor(mouse_pos)
