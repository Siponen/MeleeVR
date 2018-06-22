extends Area

var is_grabbing = false

func _ready():
	connect("body_entered", self, "_on_body_enter")
	pass
	
func _on_body_enter(body):
	
	pass