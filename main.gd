extends Node3D

var orbitsphere_scene = preload("res://orbit_sphere/orbit_sphere.tscn")

var TotalDiagonal := 100.0
var TotalHeight := 100

func _ready() -> void:
	many_orbit_sphere(10)

func _process(delta: float) -> void:
	move_camera(delta)


func move_camera(_delta: float) -> void:
	var t = -Time.get_unix_time_from_system() /2.3
	var r = TotalDiagonal *1.0
	$Camera3D.position = Vector3( sin(t)*r, sin(t*1.3)*TotalHeight *2, cos(t)*r )
	$Camera3D.look_at(Vector3.ZERO)


var orbsph_list :Array =[]
func many_orbit_sphere(n :int) -> void:
	var orbit_r = TotalDiagonal/2 *1.5
	for i in n:
		var ob_r = orbit_r #+ orbit_r/n*i
		var sp_r = orbit_r / 50
		var axis = Vector3.UP.rotated(Vector3.RIGHT.rotated(Vector3.UP,2*PI/n*i), PI/6 )
		var orsp = orbitsphere_scene.instantiate(
			).궤도설정(ob_r, 1, axis, 2*PI/n*i
			).구설정(sp_r, 0, Vector3.UP
			).구재질설정(Global3d.get_color_mat(NamedColorList.color_list.pick_random()[0])
			).궤도재질설정(Global3d.get_color_mat(NamedColorList.color_list.pick_random()[0])
		)
		orbsph_list.append(orsp)
		add_child(orsp)

func orbit_pos() -> void:
	for n in orbsph_list:
		n.position = Vector3.ZERO
