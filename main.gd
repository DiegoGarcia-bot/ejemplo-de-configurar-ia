extends Node3D

const TOTAL_COINS := 8

var score := 0

@onready var player = $Player
@onready var score_label: Label = $HUD/ScoreLabel
@onready var win_panel: Control = $HUD/WinPanel
@onready var restart_button: Button = $HUD/WinPanel/CenterContainer/VBoxContainer/RestartButton


func _ready() -> void:
    for coin in $Coins.get_children():
        coin.collected.connect(_on_coin_collected)
    restart_button.pressed.connect(_on_restart_pressed)
    win_panel.hide()
    _update_score()


func _on_coin_collected() -> void:
    score += 1
    _update_score()
    if score >= TOTAL_COINS:
        player.can_move = false
        win_panel.show()


func _update_score() -> void:
    score_label.text = "Coins: %d / %d" % [score, TOTAL_COINS]


func _on_restart_pressed() -> void:
    get_tree().reload_current_scene()
