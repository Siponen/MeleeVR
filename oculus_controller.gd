extends ARVRController

signal controller_activated(controller)

onready var ws = ARVRServer.world_scale
var controller_id

func _ready():
	# hide to begin with
	visible = false
		
	# set our initial controller mesh scale
	$controller_mesh.scale = Vector3(ws, ws, ws)

func _process(delta):
	# apply changes to our world scale
	var new_ws = ARVRServer.world_scale
	if (ws != new_ws):
		ws = new_ws
		$controller_mesh.scale = Vector3(ws, ws, ws)
	
	if !get_is_active():
		visible = false
	elif !visible:
		# make it visible
		visible = true
		emit_signal("controller_activated", self)