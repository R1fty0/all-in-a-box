extends Node

# | = union 
var item_in_hand: Photo 

func _input(event):
	if event.is_action_pressed("use") and is_hand_empty():
		pass
		
func is_hand_empty() -> bool:
	if item_in_hand == null:
		return true
	else:
		return false 

func pick_up_item():
	pass

func drop_item():
	pass 
