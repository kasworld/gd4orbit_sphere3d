extends Node3D

var orbitsphere_scene = preload("res://orbit_sphere/orbit_sphere.tscn")

var TotalDiagonal := 100.0
var TotalHeight := 100

func _ready() -> void:
	make_orbit_sphere(90, TotalDiagonal/2 *1.5)
	visible_count = 3
	count_inc = 1

var visible_count :int
var count_inc :int
func change_visible_count() -> void:
	visible_count += count_inc
	if visible_count > orbsph_list.size():
		count_inc = -1
		visible_count = orbsph_list.size()
	if visible_count < 3:
		count_inc = 1
		visible_count = 3
	change_궤도(visible_count, TotalDiagonal/2 *1.5)

var orbsph_list :Array = []
func make_orbit_sphere(n :int, orbit_r :float) -> void:
	var co1 := Color.YELLOW
	var co2 := Color.RED
	for i in n:
		var ob_r = orbit_r
		var sp_r = orbit_r / 50
		var axis = Vector3.UP.rotated(Vector3.RIGHT.rotated(Vector3.UP,2*PI/n*i), PI/6 )
		var rate := (i as float) / (n as float)
		var orsp = orbitsphere_scene.instantiate(
			).궤도설정(ob_r, 1, axis, 2*PI/n*i
			).구설정(sp_r, 0, Vector3.UP
			).구색설정(co2.lerp(co1, rate)
			).궤도색설정(co1.lerp(co2, rate)
		)
		orbsph_list.append(orsp)
		add_child(orsp)

func change_궤도(n :int, orbit_r :float) -> void:
	for o in orbsph_list:
		o.hide()
	for i in n:
		var axis = Vector3.UP.rotated(Vector3.RIGHT.rotated(Vector3.UP,2*PI/n*i), PI/6 )
		orbsph_list[i].궤도설정(orbit_r, 1, axis, 2*PI/n*i)
		orbsph_list[i].show()

func orbit_pos() -> void:
	for n in orbsph_list:
		n.position = Vector3.ZERO

func _on_timer_timeout() -> void:
	change_visible_count()

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
