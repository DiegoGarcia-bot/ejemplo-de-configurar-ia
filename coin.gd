extends Area3D

signal collected

const SPIN_SPEED := 3.0
const BOB_HEIGHT := 0.15

var _collected := false
var _base_y := 0.0
var _time := 0.0


func _ready() -> void:
    _base_y = position.y
    _time = randf() * TAU
    body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
    rotate_y(SPIN_SPEED * delta)
    _time += delta * 2.0
    position.y = _base_y + sin(_time) * BOB_HEIGHT


func _on_body_entered(body: Node3D) -> void:
    if _collected or not body.is_in_group("player"):
        return
    _collected = true
    collected.emit()
    queue_free()
