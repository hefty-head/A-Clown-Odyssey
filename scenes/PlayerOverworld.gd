extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var rayNode
export var moveSpeed = 200
var xRay = 0
var yRay = 1
var world
export var canMove = true
var moving = false
var canInteract = true
var resultUp
var resultDown
var resultLeft
var resultRight



var isFacing = "up"

func _ready():
	set_fixed_process(true)
	rayNode = get_node("RayCast2D")
	world = get_world_2d().get_direct_space_state()
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func _fixed_process(delta):
	movement(delta)
	set_process_input(true)
	if !moving and canMove:
		#print("checking result")
		 resultUp = world.intersect_point(get_pos() + Vector2(0, -40))
		 resultDown = world.intersect_point(get_pos() + Vector2(0, 40))
		 resultLeft = world.intersect_point(get_pos() + Vector2(-40, 0))
		 resultRight = world.intersect_point(get_pos() + Vector2(40, 0))
	interact(delta)
func movement(delta):
	var motion = Vector2()
	if(canMove):
		if (Input.is_action_pressed("ui_up")):
			motion += Vector2(0, -1)
			rayNode.set_rotd(180)
			xRay = 0
			yRay = 1
			moving = true
			isFacing = "up"
		elif (Input.is_action_pressed("ui_down")):
			motion += Vector2(0, 1)
			rayNode.set_rotd(0)
			xRay = 0
			yRay = -1
			moving = true
			isFacing = "down"
		elif (Input.is_action_pressed("ui_left")):
			motion += Vector2(-1, 0)
			rayNode.set_rotd(270)
			xRay = -1
			yRay = 0
			moving = true
			isFacing = "left"
		elif (Input.is_action_pressed("ui_right")):
			motion += Vector2(1, 0)
			rayNode.set_rotd(90)
			xRay = 1
			yRay = 0
			moving = true
			isFacing = "right"
		else:
			moving = false
			canInteract = true
		motion = motion.normalized()*moveSpeed*delta
		move(motion)
		if(moving == true):
			canInteract = false

func interact(delta):
	if(Input.is_action_pressed("ui_interact")):
		if(isFacing == "up"):
			interaction(resultUp)
		elif(isFacing == "down"):
			interaction(resultDown)
		elif(isFacing == "left"):
			interaction(resultLeft)
		elif(isFacing == "right"):
			interaction(resultRight)
func interaction(result):
	print(result)
	for dictionary in result:
		if(typeof(dictionary.collider) == TYPE_OBJECT and dictionary.collider.has_node("Interact")):
			get_node("Camera2D/Dialogue").set_hidden(false)
			get_node("Camera2D/Dialogue")._print("FFFFFFFFFFFFFFFFFFFFFF")