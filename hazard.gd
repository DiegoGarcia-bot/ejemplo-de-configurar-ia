extends Area3D

@export var direction := Vector3.RIGHT
@export var distance := 6.0
@export var speed := 3.0

var _origin := Vector3.ZERO
var _t := 0.0


func _ready() -> void:
    _origin = position
    body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
    _t += delta * speed / maxf(distance, 0.01)
    position = _origin + direction.normalized() * sin(_t) * distance


func _on_body_entered(body: Node3D) -> void:
    if body.is_in_group("player") and body.has_method("respawn"):
        body.respawn()
