extends CharacterBody3D

const SPEED := 6.0
const ACCELERATION := 40.0
const FRICTION := 50.0
const JUMP_VELOCITY := 8.0
const GRAVITY := 22.0
const TURN_SPEED := 12.0
const FALL_LIMIT := -15.0

var can_move := true
var spawn_position := Vector3.ZERO

@onready var model: Node3D = $Model


func _ready() -> void:
    spawn_position = global_position
    add_to_group("player")


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y -= GRAVITY * delta

    var input_dir := Vector2.ZERO
    if can_move:
        if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
            input_dir.y -= 1.0
        if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
            input_dir.y += 1.0
        if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
            input_dir.x -= 1.0
        if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
            input_dir.x += 1.0
        if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
            velocity.y = JUMP_VELOCITY

    input_dir = input_dir.normalized()
    var direction := Vector3(input_dir.x, 0.0, input_dir.y)

    if direction != Vector3.ZERO:
        velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCELERATION * delta)
        velocity.z = move_toward(velocity.z, direction.z * SPEED, ACCELERATION * delta)
        var target_angle := atan2(-direction.x, -direction.z)
        model.rotation.y = lerp_angle(model.rotation.y, target_angle, TURN_SPEED * delta)
    else:
        velocity.x = move_toward(velocity.x, 0.0, FRICTION * delta)
        velocity.z = move_toward(velocity.z, 0.0, FRICTION * delta)

    move_and_slide()

    if global_position.y < FALL_LIMIT:
        respawn()


func respawn() -> void:
    global_position = spawn_position
    velocity = Vector3.ZERO
