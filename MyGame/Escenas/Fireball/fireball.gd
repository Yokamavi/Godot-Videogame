extends Area2D

@export var animacion: AnimatedSprite2D
@export var animationPlayer: AnimationPlayer
@export var area: Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion.play("default")
	animationPlayer.play("volar")
	area.body_entered.connect(_matar_jugador)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _matar_jugador(body: Node2D) -> void:
	if body.has_method("morir"):
		body.morir()
