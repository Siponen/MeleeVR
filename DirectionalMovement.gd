extends Spatial

export (NodePath) var origin = null
export (NodePath) var camera = null
export (NodePath) var controller = null

export var player_height = 1.8 setget set_player_height, get_player_height
export var player_radius = 0.4 setget set_player_radius, get_player_radius

var origin_node = null
var camera_node = null
var controller_node = null

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
	set_player_height(player_height)
	set_player_radius(player_radius)
	pass

func _physics_process(delta):
	if controller_node.get_is_active():
		var forward_backward = controller_node.get_joystick_axis(1)
		var leftHandTracker = ARVRServer.get_tracker(0) #Change this later to look for the bounded move controller id, now we hardcode it to left hand.
		if leftHandTracker != null:
			#Position + orientation + forward or backwards direction
			var theTransform = leftHandTracker.get_transform(false)
			var forward = theTransform.basis.z
			#Ignore all unnecessary axes. We only want oriention along y axis, 360 degrees around the player
			forward.y = 0
			origin_node.global_transform = origin_node.global_transform.translated(forward * -forward_backward)
	pass