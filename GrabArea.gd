extends Area
var parent

var closestBodyToGrab = null

func _ready():
	parent = get_node("../..")
	connect("body_entered", self ,"_body_entered")
	connect("body_exited", self, "_body_exited")
	pass

func _body_entered(body):
	if body.get_collision_layer_bit(1):
		closestBodyToGrab = body
		print(str(body) + " entered grab zone")
	pass

func _body_exited(body):
	if body.get_collision_layer_bit(1):
		closestBodyToGrab = null
		print(str(body) + " left grab zone")
	pass