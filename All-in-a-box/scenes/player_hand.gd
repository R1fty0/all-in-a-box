extends Node3D

# NOTE: objects require a selection highlighter in order to be interactable 

@export var pin_mask: int = 3
@export var held_object_height: float = 9.0

@onready var camera = %Camera3D

var item_in_hand: Variant
var is_holding_pin: bool = false 

func _process(delta):
	if !_is_hand_empty():
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_dir = camera.project_ray_normal(mouse_pos)
		var plane = Plane(Vector3.UP, held_object_height)
		var intersection = plane.intersects_ray(ray_origin, ray_dir)
		if intersection != null:
			item_in_hand.global_position = intersection

func _input(event): 
	# Drop item
	if !_is_hand_empty() and event.is_action_pressed("use"):
		is_holding_pin = false
		item_in_hand = null

	# Pick up item
	elif _is_hand_empty() and event.is_action_pressed("use"):
		var result = _shoot_ray_from_mouse(event)
		if result and result.has("collider"):
			var object = result.collider
			if object is SelectionHighlighter:
				var object_root = object.parent
				if object_root is Photo or object_root is _Pin or object_root is MagnifyingGlass:
					item_in_hand = object_root
					if object_root is _Pin:
						is_holding_pin = true

func _set_col_mask(is_holding_pin: bool = false):
	var all_layers = 0xFFFFFFFF
	var mask
	if is_holding_pin:
		mask = all_layers & ~(1 << (pin_mask - 1))
	else:
		mask = all_layers
	return mask

func _set_query_parameters(origin, end, col_mask):
	var ray_parameters:= PhysicsRayQueryParameters3D.new()
	ray_parameters.from = origin
	ray_parameters.to = end
	ray_parameters.collision_mask = col_mask
	return ray_parameters

func _shoot_ray_from_mouse(event) -> Dictionary:
	var mouse_pos = event.position
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)
	var ray_length = 1000.0  
	var ray_end = ray_origin + ray_dir * ray_length
	var space_state = get_viewport().world_3d.direct_space_state
	var mask = _set_col_mask(false)
	var query_param = _set_query_parameters(ray_origin, ray_end, mask)
	var result = space_state.intersect_ray(query_param)
	return result

# Returns true if the player isn't holding anything 
func _is_hand_empty() -> bool:
	if item_in_hand == null:
		return true
	else:
		return false
