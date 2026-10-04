extends CharacterBody2D

@export var raycast_derecha: RayCast2D
@export var raycast_izquierda: RayCast2D
@export var area: Area2D
@export var fuego: Area2D
@export var animacion: AnimatedSprite2D
@export var animacion_fuego: AnimatedSprite2D
@export var pivote_fuego: Node2D

const SPEED = 100
const VELOCIDAD_FUEGO = 3.0

var velocidad_actual = SPEED

func _ready() -> void:
	area.body_entered.connect(_on_area_body_entered)
	fuego.body_entered.connect(_on_fuego_body_entered)
	animacion.play("idle")          
	animacion_fuego.play("default")    

func _physics_process(delta: float) -> void:
	
	# Órbita del fuego
	pivote_fuego.rotation += VELOCIDAD_FUEGO * delta
	# Mantiene el sprite del fuego derecho mientras orbita
	animacion_fuego.global_rotation = 0
	
	
	# Cambio de dirección al chocar con una pared
	if raycast_derecha.is_colliding():
		velocidad_actual = -SPEED
	if raycast_izquierda.is_colliding():
		velocidad_actual = SPEED

	# Voltear sprite según dirección
	animacion.flip_h = velocidad_actual < 0

	# Volando: sin gravedad
	velocity.x = velocidad_actual
	velocity.y = 0

	move_and_slide()


func _on_area_body_entered(body: Node2D) -> void:
	animacion.play("death")
	await get_tree().create_timer(0.5).timeout
	queue_free()

# El jugador toca la llama -> el jugador muere
func _on_fuego_body_entered(body: Node2D) -> void:
	if body.has_method("morir"):
		body.morir()
