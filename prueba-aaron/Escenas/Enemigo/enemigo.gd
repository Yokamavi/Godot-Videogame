extends CharacterBody2D

@export var raycast: RayCast2D
@export var animacion: AnimatedSprite2D
@export var area_danho: Area2D
@export var forma_danho: CollisionShape2D  # zona_danho
@export var area_deteccion: Area2D

const FRAMES_GOLPE := [4, 5]

var ataque: bool = false
var velocidad: float = -100.0

func _ready() -> void:
	forma_danho.disabled = true
	area_deteccion.body_entered.connect(_on_deteccion_body_entered)
	area_danho.body_entered.connect(_on_danho_body_entered)
	animacion.frame_changed.connect(_on_frame_changed)
	animacion.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if raycast.get_collider() != null:
		girar()

	if ataque:
		velocity.x = 0
	else:
		velocity.x = velocidad
		animacion.play("walk")

	move_and_slide()

func girar() -> void:
	velocidad *= -1
	animacion.flip_h = not animacion.flip_h
	raycast.target_position *= -1
	area_danho.position.x *= -1
	area_deteccion.position.x *= -1   # antes tenías += -1, que solo movía 1 píxel

func _on_deteccion_body_entered(_body: Node2D) -> void:
	if not ataque:
		ataque = true
		animacion.play("attack")

func _on_frame_changed() -> void:
	if animacion.animation == "attack":
		# Activa el área de daño solo en los frames 4 y 5
		forma_danho.set_deferred("disabled", not (animacion.frame in FRAMES_GOLPE))

func _on_danho_body_entered(body: Node2D) -> void:
	if body.has_method("morir"):
		body.morir()

func _on_animation_finished() -> void:
	if animacion.animation == "attack":
		ataque = false
		forma_danho.set_deferred("disabled", true)
