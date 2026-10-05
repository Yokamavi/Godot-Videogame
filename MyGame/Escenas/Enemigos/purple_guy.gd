extends CharacterBody2D
@export var raycast_caida_derecha: RayCast2D
@export var raycast_pared_izquierda: RayCast2D
@export var raycast_pared_derecha: RayCast2D
@export var area: Area2D
@export var raycast_caida_izquierda: RayCast2D
@export var animacion: AnimatedSprite2D
const SPEED = 100
var velocidad_actual = SPEED
func _ready() -> void:
	area.body_entered.connect(_on_danho_body_entered)
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	#Animacion
	if velocidad_actual != 0:
		animacion.play("walk")
		
	if velocidad_actual < 0:
		animacion.flip_h = true
	else:
		animacion.flip_h = false
	if raycast_pared_derecha.is_colliding():
		velocidad_actual = -SPEED
		
	if raycast_pared_izquierda.is_colliding():
		velocidad_actual = SPEED
	
	if not raycast_caida_izquierda.is_colliding():
		velocidad_actual = SPEED
	
	if not raycast_caida_derecha.is_colliding():
		velocidad_actual = -SPEED

	velocity.x = velocidad_actual

	move_and_slide()
	
	

func _on_danho_body_entered(body: Node2D) -> void:
	if body.has_method("morir"):
		body.morir()
