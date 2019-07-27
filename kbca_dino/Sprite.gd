extends KinematicBody2D

var attack : Area2D
var timeAtack

var vel = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	timeAtack = 0;
	attack = $Attack
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moviment(delta)
	atack(delta)
	pass

func moviment(delta):
	if (timeAtack <=0):
		if Input.is_key_pressed(KEY_DOWN):
			move_and_collide(Vector2(0,vel*0.5)* delta)
		if Input.is_key_pressed(KEY_UP):
			move_and_collide(Vector2(0,-vel*0.5) * delta)
		if Input.is_key_pressed(KEY_LEFT):
			move_and_collide(Vector2(-vel,0) * delta)
			invert_side(true);
		if Input.is_key_pressed(KEY_RIGHT):
			move_and_collide(Vector2(vel,0) * delta)
			invert_side(false);
	pass
	
func atack(delta):
	if Input.is_action_just_pressed("atack"):
		attack.get_node("AttackCollisionShape").disabled = false
	if !attack.get_node("AttackCollisionShape").disabled:
		timeAtack += delta
		print(timeAtack)
	if timeAtack > 0.15:
		attack.get_node("AttackCollisionShape").disabled = true
		timeAtack = 0;
	pass

func _on_Attack_body_entered(body):
	if (body.has_method("get_type")):
		if (body.get_type() == "enemy"):
			body.take_damage()
	pass

func invert_side (left_side):
	if (left_side):
		$Sprite.set_flip_h(true)
		$Attack.position.x = -70
	else :
		$Sprite.set_flip_h(false)
		$Attack.position.x = 70