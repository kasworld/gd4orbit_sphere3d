extends Node3D
class_name Bracelet

var orbitsphere_scene = preload("res://orbit_sphere/orbit_sphere.tscn")

var orbit_r := 100.0
var co1 := Color.MAGENTA
var co2 := Color.YELLOW

func init(n :int, ob_r :float) -> void:
	orbit_r = ob_r
	for i in n:
		var sp_r = orbit_r / 50
		var axis = Vector3.UP.rotated(Vector3.RIGHT.rotated(Vector3.UP,2*PI/n*i), PI/6 )
		var orsp = orbitsphere_scene.instantiate().구설정(sp_r, 0, Vector3.UP	)
		orbsph_list.append(orsp)
		add_child(orsp)

var orbsph_list :Array = []
func change_궤도(n :int) -> void:
	for o in orbsph_list:
		o.hide()
	for i in n:
		var axis = Vector3.UP.rotated(Vector3.RIGHT.rotated(Vector3.UP,2*PI/n*i), PI/6 )
		var rate := (i as float) / (n as float) *2
		if rate > 1 :
			rate = 2 - rate
		orbsph_list[i].궤도설정(orbit_r, 1, axis, 2*PI/n*i
			).구색설정(co2.lerp(co1, rate)
			).궤도색설정(co1.lerp(co2, rate)
		)
		orbsph_list[i].show()

func _process(delta: float) -> void:
	if orbsph_list.size() == 0:
		return
	change_visible_count()

var visible_count :int = 3
var count_inc :int = 1
func change_visible_count() -> void:
	visible_count += count_inc
	if visible_count > orbsph_list.size():
		count_inc = -1
		visible_count = orbsph_list.size()
	if visible_count < 3:
		count_inc = 1
		visible_count = 3
	change_궤도(visible_count)
