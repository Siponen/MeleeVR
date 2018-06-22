extends Spatial

export (NodePath) var origin = null
export (NodePath) var camera = null
export (NodePath) var controller = null
export (NodePath) var body = null

export var player_height = 1.8 setget set_player_height, get_player_height
export var player_radius = 0.4 setget set_player_radius, get_player_radius

var origin_node = null
var camera_node = null
var controller_node = null
var body_node = null
var movementTrackerId = 0

var direction = Vector3(0.0, 0.0, 0.0)
var gravity = -30.0

func get_player_height():
	return player_height

func set_player_height(p_height):
	player_height = p_height
	pass

func get_player_radius():
	return player_radius

func set_player_radius(p_radius):
	player_radius = p_radius
	pass

func _ready():
	origin_node = get_node(origin)
	camera_node = get_node(camera)
	controller_node = get_node(controller)
	body_node = get_node(body)
	set_player_height(player_height)
	set_player_radius(player_radius)
	
	#Determine the tracker id for our movement controller.
	movementTrackerId = controller_node.controller_id-1
	if movementTrackerId < 0: 
		movementTrackerId = 0
	pass

func _physics_process(delta):
	if controller_node.get_is_active():
		if ARVRServer.get_tracker_count() > 0:
			directionalMovement()
	pass
	
func directionalMovement():
	var movementTracker = ARVRServer.get_tracker(movementTrackerId)
	if movementTracker != null:
		var forward_backward = controller_node.get_joystick_axis(1)
		var directionTransform = movementTracker.get_transform(false)
		var forward = directionTransform.basis.z
		forward.y = 0 #Ignore all unnecessary axes. We only want oriention along y axis, 360 degrees around the player
		
		#Physics collision
		#Move the kinematic and translate the origin to it
		var slope_min_velocity = 0.05
		var max_slides=4
		var floor_max_angle=0.785398
		#body_node.move_and_slide(forward, Vector3(0,1,0), slope_min_velocity, max_slides, floor_max_angle )
		
		#Move the origin directly
		origin_node.global_transform = origin_node.global_transform.translated(forward * -forward_backward)
	pass