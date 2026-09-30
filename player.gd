extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var deathasound: AudioStreamPlayer2D = $Deathasound

const SPEED = 300.0
const JUMP_VELOCITY = -850.0
var alive = true
var can_move = true 

func _physics_process(delta: float) -> void:
	if !alive:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if can_move:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# Ganti "move_left" dan "move_right" dengan nama aksi di Project Settings > Input Map Anda,
		# atau gunakan "ui_left" dan "ui_right" untuk tombol panah bawaan.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# Add animation logic
		if velocity.x > 1 or velocity.x < -1:
			animated_sprite_2d.animation = "running"
		else:
			animated_sprite_2d.animation = "idle"

		# Mengatur arah menghadap sprite (opsional, agar karakter berbalik ke kiri/kanan)
		if direction > 0:
			animated_sprite_2d.flip_h = false
		elif direction < 0:
			animated_sprite_2d.flip_h = true

	# Wajib ada agar player bisa bergerak dan mendeteksi tabrakan
	move_and_slide()

func die() -> void:
	deathasound.play()
	animated_sprite_2d.animation = "dying"
	alive = false
