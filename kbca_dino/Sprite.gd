extends KinematicBody2D

var hp = 100

var attack : Area2D
var timeAtack

var vel = 250

var attack_seq = 0;
var attack_list = ["attack1","attack2","attack2","attack1","attack1","attack2","attack2"];

var cur_state = "null"
var new_state = "idle"
var looking_to = "left";

var atacando = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timeAtack = 0;
	attack = $Sprite/Attack
	change_state()
	changeLook()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (atacando):
		return
	moviment(delta)
	atack(delta)
	if (cur_state != new_state):
		change_state()
	if Input.is_key_pressed(KEY_D):
		takeDamage(1)
	pass

func moviment(delta):
	if (!atacando):
		new_state = "idle"
		if Input.is_key_pressed(KEY_DOWN):
			move_and_collide(Vector2(0,vel*0.7)* delta)
			new_state = "walk"
		elif Input.is_key_pressed(KEY_UP):
			move_and_collide(Vector2(0,-vel*0.7) * delta)
			new_state = "walk"
		if Input.is_key_pressed(KEY_LEFT):
			move_and_collide(Vector2(-vel,0) * delta)
			if (looking_to == "right"):
				looking_to = "left"
				changeLook()
			new_state = "walk"
		elif Input.is_key_pressed(KEY_RIGHT):
			move_and_collide(Vector2(vel,0) * delta)
			if (looking_to == "left"):
				looking_to = "right"
				changeLook()
			new_state = "walk"
	pass
	
func changeLook():
	if (looking_to == "left"):
		$Sprite.set_flip_h(false)
		$Sprite/Attack.position.x = abs($Sprite/Attack.position.x) * (-1)
		$Sprite/Body.position.x = abs($Sprite/Body.position.x) * (-1)
	else:
		$Sprite.set_flip_h(true)
		$Sprite/Attack.position.x = abs($Sprite/Attack.position.x)
		$Sprite/Body.position.x = abs($Sprite/Body.position.x)
	

func change_state():
	if (new_state == "idle"):
		$Sprite/AnimationPlayer.play("idle")
	elif (new_state == "walk"):
		$Sprite/AnimationPlayer.play("walk")
	
	cur_state = new_state
	pass

func atack(delta):
	if Input.is_action_just_pressed("atack"):
		attack.get_node("AttackCollisionShape").disabled = false
		attack_seq += 1
		if (attack_seq >= len(attack_list)):
			attack_seq = 0
		print("A:", attack_seq, attack_list[attack_seq])
		$Sprite/AnimationPlayer.play(attack_list[attack_seq])
		new_state = "attack"
		atacando = true
	if !attack.get_node("AttackCollisionShape").disabled:
		timeAtack += delta
	if timeAtack > 0.35:
		attack.get_node("AttackCollisionShape").disabled = true
	elif timeAtack > 0.45:
		attack.get_node("AttackCollisionShape").disabled = true
		timeAtack = 0;
		attack_seq = 0
		new_state = "idle"
	pass

func _on_Attack_body_entered(body):
	if (body.has_method("get_type")):
		if (body.get_type() == "enemy"):
			body.take_damage()
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	print ("terminei uma animação")
	atacando = false
	$Sprite/AnimationPlayer.play("idle")
	new_state = "idle"
	pass # Replace with function body.
	
func takeDamage(value):
	hp -= value
	if(hp<0):
		hp = 0
	print(hp)
	pass
