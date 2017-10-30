extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var rayNode
export var moveSpeed = 200
var xRay = 0
var yRay = 1
func _ready():
	set_fixed_process(true)
	rayNode = get_node("RayCast2D")
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func _fixed_process(delta):
	movement(delta)
	set_process_input(true)
func movement(delta):
	var motion = Vector2()
	if (Input.is_action_pressed("ui_up")):
		motion += Vector2(0, -1)
		rayNode.set_rotd(180)
		xRay = 0
		yRay = 1
	elif (Input.is_action_pressed("ui_down")):
		motion += Vector2(0, 1)
		rayNode.set_rotd(0)
		xRay = 0
		yRay = -1
	elif (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
		rayNode.set_rotd(270)
		xRay = -1
		yRay = 0
	elif (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
		rayNode.set_rotd(90)
		xRay = 1
		yRay = 0
	motion = motion.normalized()*moveSpeed*delta
	move(motion)
func _input(event):
	if(event.is_action_pressed("ui_accept")):
		var space_state = get_world_2d().get_direct_space_state()
		var result = space_state.intersect_ray( get_global_pos(), Vector2(get_global_pos().x + 200*xRay,get_global_pos().y + 200*yRay), [self] )
		if (not result.empty()):
			if(result.collider.isTalkable == 1):
				get_node("Camera2D/Polygon2D/RichTextLabel").set_opacity(.5)
				#result.collider._ready()
				result.collider._input("ui_accept")
			