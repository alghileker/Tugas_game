extends Node2D

var score: int = 0
var level: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()

func _load_level(level_number: int) -> void:

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setup_level() -> void:
	
	var exit = $LevelRoot.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
	
	var buahsakti = $LevelRoot.get_node_or_null("buahsakti")
	if buahsakti:
		for enemy in buahsakti.get_children():
			enemy.collected.connect(increase_score)
	
	
	var enemies =$LevelRoot.get_node_or_null("Enemy")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)



func _on_player_died(body):
	body.die()
	print("Player Killed")

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "player":
		level += 1
		print(level)
		body.can_move = false
	
	






func increase_score() -> void:
	score += 1
	print(score)
