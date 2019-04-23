extends RigidBody



func _physics_process(delta):
	extends RigidBody

var my_power = 20.0

func _integrate_forces(state):
    if Input.is_action_pressed("my_left"):
        state.add_force(Vector3(-my_power, 0, 0), Vector3())
    if Input.is_action_pressed("my_right"):
        state.add_force(Vector3(my_power, 0, 0),  Vector3())
    if Input.is_action_pressed("my_up"):
        state.add_force(Vector3(0, 0, -my_power), Vector3())
    if Input.is_action_pressed("my_down"):
        state.add_force(Vector3(0, 0, my_power),  Vector3())
	
	pass
