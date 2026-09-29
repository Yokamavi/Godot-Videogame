extends CharacterBody2D

@export var raycast: RayCast2D
@export var raycast2: RayCast2D
@export var animacion: AnimatedSprite2D
var ataque: bool = false
var velocidad: float = -100
func _physics_process(delta: float) -> void:
	velocity.x = velocidad
	if raycast2.get_collider() != null:
		velocidad *= -1
		animacion.flip_h = not animacion.flip_h
		raycast2.target_position *= -1
		
	if ataque:
		velocity.x = 0
		animacion.play("attack");
	elif velocity.x == 0:
		animacion.play("idle")
	else:
		animacion.play("walk")
		
	if raycast.get_collider() != null:
		ataque = true
		
		
	move_and_slide()
	
func _on_animated_sprite_2d_animation_finished():
	if animacion.animation == "atack"
