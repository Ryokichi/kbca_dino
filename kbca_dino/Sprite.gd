extends KinematicBody2D

var hp = 100

var attack : Area2D
var timeAtack

var vel = 250

var attack_seq = 0;
var attack_list = ["attack1","attack2","attack2","attack1","attack1","attack2","attack2"];

var cur_state = "null"
var new_state = "idle"
var looking_to = "right";

var atacando = false
var wait_time = 0;

var soco_pos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	soco_pos = $Sprite/Attack.position.x
	timeAtack = 0;
	attack = $Sprite/Attack
	change_state()
	changeLook()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_z_index(position.y)
	if (atacando):
		if ($Sprite/Attack.position.x != 0):
			$Sprite/Attack.position.x = 0
		else:
			$Sprite/Attack.position.x = soco_pos
			if (looking_to != "left"):
				$Sprite/Attack.position.x = -soco_pos
			
		return
	if (cur_state != new_state):
		change_state()
	if Input.is_key_pressed(KEY_D):
		takeDamage(1)
		
	atack(delta)
	wait_time -= delta
	if (wait_time > 0):
		return
	else:
		wait_time = 0
	moviment(delta)
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
		wait_time = 100
		timeAtack = 0
		attack.get_node("Shape").disabled = false
		attack_seq += 1
		if (attack_seq >= len(attack_list)):
			attack_seq = 0
		$Sprite/AnimationPlayer.play(attack_list[attack_seq])
		new_state = "attack"
		atacando = true
		
	if !attack.get_node("Shape").disabled:
		timeAtack += delta
	if timeAtack > 0.35 && timeAtack <= 0.45:
#		$Sprite/Attack.set_scale(Vector2(0,0))
		attack.get_node("Shape").disabled = true
	elif timeAtack > 0.45:
		attack.get_node("Shape").disabled = true
		timeAtack = 0;
		attack_seq = 0
		new_state = "idle"
	pass

func _on_Attack_body_entered(body):
	var avo = body.get_parent().get_parent();
	print("Tem coisa aqui: ", body.name)
		
	if (avo.has_method("get_type")):
		if (avo.get_type() == "enemy"):
			avo.take_damage()
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	atacando = false
	$Sprite/AnimationPlayer.play("idle")
	wait_time = 0.2
	new_state = "null"
	pass # Replace with function body.
	
func takeDamage(value):
	hp -= value
	if(hp<0):
		hp = 0
	print(hp)
	pass