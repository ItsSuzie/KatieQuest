extends CharacterBody2D
class_name PlayerOverworldController

### Summary:
### Baseclass for actor controling 
###

### Variable - Private to this class only
var moveSpeed : int # Player movement speed 
var mov : Vector2	# to store the movment vector of the actor

### Store references to the nodes used on this actor
# input
@onready var playerInputNode : Node = null
@onready var statMoveSpeedNode : Node = null



### Functions:

# Called when the node enters the scene tree for the first time.
func _ready():
	# reference to input relation nodes
	playerInputNode = $playerInput_class
	statMoveSpeedNode = $actorStatMoveSpeed_class



func _process(_delta):	
	
	# Checks to see if one of the input nodes is avaliable. If it is, start processing
	# it's movement values to move this actor.
	
	# If an input class exists, continue to the processing
	if playerInputNode == null:
		printerr("No input related node attached to this actor. Please add either an player input, enemy AI or Friendly AI node to this.")
	else:
		if playerInputNode != null:
			mov = playerInputNode.playerInputProcessing()
			updateUIGraphics()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# move the actor
	actorMovement(delta)

### Updates actor graphics
func updateActorGraphics():
	pass

### Update any and all ui graphics
func updateUIGraphics():
	pass

### Handles movement of the actor
func actorMovement(delta):
	if statMoveSpeedNode != null:
		moveSpeed = statMoveSpeedNode.MoveSpeedCurrent
		var calculatedMoveSpeed = (moveSpeed * delta) * 100
		#print(str(calculatedMoveSpeed))
		
		velocity = mov.normalized() * calculatedMoveSpeed
		move_and_slide()
	else:
		print("Node 'actorStatMoveSpeed_Class' missing from this actor. Cannot move.")
		print("Please add this class to allow the actor to move.")
