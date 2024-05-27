extends overworldActorNode

class_name playerInput_class

func playerInputProcessing():
	#Gets player input as a float, X and Y movement
	var x_mov = Input.get_action_strength("strafeRight") - Input.get_action_strength("strafeLeft")
	var y_mov = Input.get_action_strength("moveBack") - Input.get_action_strength("moveForward")
	var mov = Vector2(x_mov, y_mov) # apples it to a vector2
	
	return mov	
	
