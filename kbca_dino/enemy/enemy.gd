extends KinematicBody2D

onready var mama = self.get_parent()

var type = "enemy"
var status = "alive"
var vulnerable = true
var damage_time = 0
var hp = 3

func _ready():
	print(mama.name)
	pass # Replace with function body.

func _process(delta):
	if (damage_time > 0):
		damage_time -= delta
		vulnerable = false
	elif (damage_time <= 0):
		damage_time = 0
		vulnerable = true
		
	
func get_type ():
	return type
	pass
	
func take_damage():
	if (!vulnerable):
		return
		
	hp -= 1
	damage_time = 0.3
	if (hp <= 0):
		print("Morri")
		status = "dead"
		print(self.get_parent().i_have_to_kill_you(self))
	pass