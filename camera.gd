extends Camera3D

# Angled overhead view of the whole arena.
func _ready() -> void:
    look_at(Vector3(0, 0, -1), Vector3.UP)
