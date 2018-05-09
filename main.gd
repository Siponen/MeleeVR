extends Node

func _ready():
	var vr = ARVRServer.find_interface("Oculus")
	if(vr and vr.initialize()):
		get_viewport().arvr = true
	pass