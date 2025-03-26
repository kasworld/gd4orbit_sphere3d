extends Node3D

var TotalDiagonal := 100.0
var TotalHeight := 100

func _ready() -> void:
	#$Bracelet.init(180, TotalDiagonal/2 *1.5)
	$Bracelet2.init(90, TotalDiagonal )

func _process(delta: float) -> void:
	move_camera(delta)

func move_camera(_delta: float) -> void:
	var t = -Time.get_unix_time_from_system() /2.3
	var r = TotalDiagonal *1.0
	$Camera3D.position = Vector3( sin(t)*r, sin(t*1.3)*TotalHeight *2, cos(t)*r )
	$Camera3D.look_at(Vector3.ZERO)

var key2fn = {
	KEY_ESCAPE:_on_button_esc_pressed,
}
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var fn = key2fn.get(event.keycode)
		if fn != null:
			fn.call()
	elif event is InputEventMouseButton and event.is_pressed():
		pass

func _on_button_esc_pressed() -> void:
	get_tree().quit()
