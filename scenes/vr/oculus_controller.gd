extends ARVRController

signal controller_activated(controller)
onready var ws = ARVRServer.world_scale

var tracker = null
var bumperPressed = false
var triggerPressed = false
var isDebugInput = false

var isClenchingFist = false

var previousState = {
	isHoldFist = false,
}

var currentState = {
	isHoldFist = false,
}

var objectInHand = {}

var ButtonNames = {
	#Shared button names
	15: "Back bumper fully",
	12: "Back bumper release",
	11: "Back bumper partially",
	2: "Side bumper",
	10: "Idle",
	9: "Touchpad",
	#Left Controller
	5: "Rest on X",
	6: "Rest on Y",
	7: "X",
	1: "Y",
	#Right Controller, we increment with 100 for right controller unique button names
	105: "Rest on A",
	106: "Rest on B",
	107: "A",
	101: "B"
}

func _ready():
	visible = false
	connect("button_pressed", self, "on_button_pressed")
	connect("button_release", self, "on_button_release")
	$ControllerMesh.scale = Vector3(ws, ws, ws)

func _process(delta):
	if tracker == null:
		if ARVRServer.get_tracker_count() > 0:
			tracker = ARVRServer.get_tracker(controller_id-1)
	# apply changes to our world scale
	var new_ws = ARVRServer.world_scale
	if (ws != new_ws):
		ws = new_ws
		$ControllerMesh.scale = Vector3(ws, ws, ws)
	
	if !get_is_active():
		visible = false
	elif !visible:
		# make it visible
		visible = true
		emit_signal("controller_activated", self)
		
func _physics_process(delta):
	#if get_is_active():
		#Set currentState input
		#Grab item, when holding Side bumper (2)
		#if (previousState.isHoldFist == false) and is_button_pressed(2):
		#	var pickUpBody = $GrabArea.closestBodyToGrab
			# Pick up nearby object
		#	if pickUpBody != null:
		#		objectInHand = pickUpBody
		#		print("Picked up " + str(pickUpBody.name))
		#		#Pin the item into player's hand
		#		var grabJoint = $GrabJoint
		#		grabJoint["nodes/node_a"] = $GrabJoint/StaticBody.get_path()
		#		grabJoint["nodes/node_b"] = pickUpBody.get_path()
		#		pickUpBody.global_transform.origin = grabJoint.global_transform.origin
		#		pass

		#	currentState.isHoldFist = true
		#	print("Clench fist")
			
		#Release item, Back bumper release pressed(12) and Side bumper release(2)
		#elif (currentState.isHoldFist == true) and is_button_pressed(12) and (is_button_pressed(2) == 0):
		#	currentState.isHoldFist = false
		#	if objectInHand != null:
		#		print("Dropped " + str(objectInHand))
		#		objectInHand == null
		#		pass

		#	print("Opened fist")
		#	pass
		#previousState = currentState
	pass
	
func on_button_pressed(button):
	var hand = ""
	var buttonId = button
	if get_hand() == 1:
		hand = "Left "
	elif get_hand() == 2:
		hand = "Right "
		#Increment buttonId for right hand unique button names
		if button == 5 or button == 6 or button == 7 or button == 1:
			buttonId = button + 100
	else:
		hand = "unknown "
	
	var buttonName = ""
	if ButtonNames.has(button):
		buttonName = ButtonNames[buttonId]
	else:
		buttonName = str(button)

	if isDebugInput:
		print(hand + buttonName + " pressed.")
	pass

func on_button_release(button):
	var hand = ""
	var buttonId = button
	
	if get_hand() == 1:
		hand = "Left"
	elif get_hand() == 2:
		hand = "Right"
		#Increment buttonId for right hand unique button names
		if button == 5 or button == 6 or button == 7 or button == 1:
			buttonId = button + 100
	else:
		hand = "unknown"

	var buttonName = ""
	if ButtonNames.has(button):
		buttonName = ButtonNames[button]
	else:
		buttonName = str(button)

	if isDebugInput:
		print(hand + " button " + buttonName + " released.")
	pass