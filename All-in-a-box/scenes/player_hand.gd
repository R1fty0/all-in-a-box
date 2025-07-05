extends RayCast3D

@export_group("Interaction Settings")
@export var object_height: float = 2.0

# | = union 
var item_in_hand: Photo 

func _process(delta):
	_update_raycast_to_mouse_position()
	if !_is_hand_empty():
		# Update position of object held in player hand 
		var plane = Plane(Vector3.UP, object_height)
		var hit_point = plane.intersects_ray(get_mouse_origin(), get_mouse_direction())
		item_in_hand.position = hit_point
	
# TODO: stop objects from occasionally falling thru the table 
func _input(event):
	if event.is_action_pressed("use") and _is_hand_empty():
		var collided_obj = get_collider()
		if collided_obj is Photo: 
			item_in_hand = collided_obj
	elif event.is_action_pressed("use") and !_is_hand_empty():
		item_in_hand = null

func _update_raycast_to_mouse_position():
	global_position = get_mouse_origin()
	target_position = get_mouse_direction() * 1000
	# Update raycast 
	force_raycast_update()
	

func get_mouse_origin():
	# Get mouse position 
	var mouse_pos = get_viewport().get_mouse_position()
	# Set raycast to be the same as the mouse position 
	var origin = %Camera3D.project_ray_origin(mouse_pos)
	return origin 

func get_mouse_direction():
	# Get mouse position 
	var mouse_pos = get_viewport().get_mouse_position()
	var direction = %Camera3D.project_ray_normal(mouse_pos)
	return direction 

# Returns true if the player is not holding anything in their hand 
func _is_hand_empty() -> bool:
	if item_in_hand == null:
		return true
		print("true")
	else:
		return false 
		print("false")
