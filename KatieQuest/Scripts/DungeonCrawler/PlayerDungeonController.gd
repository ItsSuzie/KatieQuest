extends Node3D

const TRAVEL_TIME := 0.3

var tween

# storing the nodes
@onready var rayForward = null
@onready var rayBack = null
@onready var rayLeft = null
@onready var rayRight = null


# Called when the node enters the scene tree for the first time.
func _ready():
	#tween = get_tree().create_tween()
	rayForward = $rayForward
	rayBack = $rayBack
	rayLeft = $rayLeft
	rayRight = $rayRight


# Checks if the incoming direction has collision.
func collisionCheck(direction):
	if direction != null:
		return direction.isColliding()
	else:
		return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("SceneChange"):
		# change the scene
		pass
		

	#if playerInputNode != null:
	#mov = playerInputNode.playerInputProcessing()
	#actorMovement()


# physics realted, runs every frame consistently
func _physics_process(_delta):
	playerMovement()

func playerMovement():
	# assigns all input varialbes
	var moveForward := Input.is_action_pressed("moveForward")
	var moveBack := Input.is_action_pressed("moveBack")
	var moveLeft := Input.is_action_pressed("strafeLeft")
	var moveRight := Input.is_action_pressed("strafeRight")
	var turnLeft := Input.is_action_pressed("turnLeft")
	var turnRight := Input.is_action_pressed("turnRight")

# Check if the tween exists, and is running, if so, do not allow input
	if tween and tween.is_running():
			return
			
	# grid based movement is done by tweening.
	if moveForward and not rayForward.is_colliding():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * 2), TRAVEL_TIME)
		
	elif moveBack and not rayBack.is_colliding():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * 2), TRAVEL_TIME)
		
	elif moveLeft and not rayLeft.is_colliding():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.LEFT * 2), TRAVEL_TIME)
		
	elif moveRight and not rayRight.is_colliding():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.RIGHT * 2), TRAVEL_TIME)
		
	elif turnLeft:
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI/2), TRAVEL_TIME)
		
	elif turnRight:
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI/2), TRAVEL_TIME)
