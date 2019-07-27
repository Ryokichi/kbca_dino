extends KinematicBody2D

onready var player = self.get_parent().get_parent().get_node("Player")

var type = "enemy"
var status = "alive"
var stunned = false
var states = ["stopped", "chasing", "ahead"]
var curr_state = states[0]
var stun_time = 0
var hp = 3
var vel= 50

var timer

func _ready():
	timer = Timer.new()
	timer.set_wait_time(1)
	timer.connect("timeout", self, "sort_state")
	timer.start()
	add_child(timer)
	
	pass # Replace with function body.
	


func sort_state():
	curr_state = states[randi() % len(states)]
	print ("Estado:", curr_state)
	timer.set_wait_time(randf() * 3 + 2)
	
	pass
	
func _process(delta):
	if (stun_time > 0):
		stun_time -= delta
		
	elif (stun_time <= 0):
		stun_time = 0
		stunned = false
		
	if (!stunned):
		if (curr_state == "chasing"):
			self.chase(delta)
		elif (curr_state == "ahead"):
			self.walk_ahead(delta)
		pass
		
	
func get_type ():
	return type
	pass
	
func take_damage():
	if (stunned):
		return
		
	stunned = true
	hp -= 1
	stun_time = 0.3
	if (hp <= 0):
		print("Morri")
		status = "dead"
		print(self.get_parent().i_have_to_kill_you(self))
	pass
	
func chase (delta):
	var ini_pos = get_position()
	var end_pos = player.get_position()
	var dif_pos = Vector2(end_pos.x - ini_pos.x, end_pos.y - ini_pos.y)
		
	var vel_x = vel if (dif_pos.x > 0) else -vel
	var vel_y = vel*0.5 if (dif_pos.y > 0) else -vel*0.5
		
	move_and_collide(Vector2(vel_x, vel_y) * delta)
	set_orientation(vel_x)
	pass
	
func walk_ahead (delta):
	var ini_pos = get_position()
	var end_pos = player.get_position()
	var dif_pos = Vector2(end_pos.x - ini_pos.x, end_pos.y - ini_pos.y)
	var vel_x = vel if (dif_pos.x > 0) else -vel
	move_and_collide(Vector2(vel_x, 0) * delta)
	set_orientation(vel_x)
	
func set_orientation (to_x):
	if (to_x > 0):
		$Sprite.set_flip_h(true)
	else :
		$Sprite.set_flip_h(false)
