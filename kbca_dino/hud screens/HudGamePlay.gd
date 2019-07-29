extends Node2D

var score
var scoreLabel
var hpBar
# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	hpBar = $ProgressBar
	scoreLabel = $ScoreLabel
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hpBar.value = get_parent().get_node("Player").hp
	scoreLabel.text = "score: " + String(score)
	if(Input.is_key_pressed(KEY_P)):
		takeScore(1)
	pass
	
func takeScore(value):
	score+= (value*100)
	$AudioDeaf.play()
	pass
