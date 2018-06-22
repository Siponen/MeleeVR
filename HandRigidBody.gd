extends RigidBody

var controller = null
const SPEED = 100
var count = 0

func _ready():
	set_as_toplevel(true)
	global_transform.origin = get_parent().global_transform.origin
	controller = get_parent()
	pass

func _integrate_forces(state):
	var targetPosition = controller.global_transform.origin
	var currentPosition = global_transform.origin
	 
	#Follow controller's angular position
	state.linear_velocity = Vector3() #Reset velocity to allow rotations
	
	#Some approach, get rotations
	var currentFacingDirection = global_transform.basis.z
	var targetFacingDirection = controller.global_transform.basis.z
	var delta = (targetFacingDirection - currentFacingDirection).normalized()
	
	#Quat approach, get rotations
	var currentFacingQuat = Quat(global_transform.basis)
	var targetFacingQuat = Quat(controller.global_transform.basis)
	var deltaQuat = targetFacingQuat - currentFacingQuat
	state.set_angular_velocity(Vector3(count*state.step,0,0))
	
	print("Cur dir: " + str(currentFacingDirection))
	print("Target dir: " + str(targetFacingDirection))
	print("Delta: " + str(delta))
	print("AV: " + str(state.angular_velocity))
	
	#Follow controller's position
	var target_position = controller.get_global_transform().origin
	var targetDirection = (targetPosition - currentPosition)
	state.add_force(targetDirection*1000,Vector3())
		
	if count % 100 == 0:
		print("Delta Angular: " + str(delta) + " Target Angular: " + str(targetFacingDirection) + " Current Angular: " + str(currentFacingDirection))
		#print("State - AV: " + str(state.angular_velocity) + " AV Damp: " + str(state.total_angular_damp) + " locks" + state.)
	count += 1
	pass