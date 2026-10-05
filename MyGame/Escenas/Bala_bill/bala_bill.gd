extends Area2D
@export var area: Area2D
var posicion = 1331
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.body_entered.connect(_matar_jugador)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x = position.x - 5
	
	if position.x <= -249.0:
		position.x = posicion
	
func _matar_jugador(body: Node2D) -> void:
	if body.has_method("morir"):
		body.morir()
