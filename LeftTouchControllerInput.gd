extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ButtonNames = {
	15: "Back bumper fully",
	12: "Back bumper release",
	11: "Back bumper partially",
	10: "Idle",
	9: "Touchpad",
	5: "Resting on X",
	6: "Resting on Y",
}


func on_button_pressed(button):
	var hand = ""
	if get_hand() == 1:
		hand = "Left"
	elif get_hand() == 2:
		hand = "Right"
	else:
		hand = "unknown"
	print(hand + " button " + str(button) + " has been pressed.")
	pass

func on_button_release(button):
	var hand = ""
	if get_hand() == 1:
		hand = "Left"
	elif get_hand() == 2:
		hand = "Right"
	else:
		hand = "unknown"
	print(hand + " button " + str(button) + " has been released.")
	pass