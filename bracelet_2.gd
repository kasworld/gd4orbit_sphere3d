extends Node3D
class_name Bracelet2

var orbit_r := 100.0
var co1 := Color.MAGENTA
var co2 := Color.YELLOW

var multimesh :MultiMesh

func init(count :int, ob_r :float) -> void:
	orbit_r = ob_r
	var mesh = TorusMesh.new()
	mesh.inner_radius = orbit_r*0.999
	mesh.outer_radius = orbit_r*1.001
	mesh.material = StandardMaterial3D.new()
	mesh.material.vertex_color_use_as_albedo = true

	multimesh = MultiMesh.new()
	multimesh.mesh = mesh
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.use_colors = true # before set instance_count
	# Then resize (otherwise, changing the format is not allowed).
	multimesh.instance_count = count
	multimesh.visible_instance_count = count

	var multi_ring = MultiMeshInstance3D.new()
	multi_ring.multimesh = multimesh
	add_child(multi_ring)

func change_궤도(n :int) -> void:
	multimesh.visible_instance_count = n
	for i in multimesh.visible_instance_count:
		#var axis = Vector3.UP.rotated(Vector3.RIGHT.rotated(Vector3.UP,2*PI/n*i), PI/6 )
		var t = Transform3D(Basis(), Vector3.ZERO)
		t = t.rotated_local(Vector3.RIGHT.rotated(Vector3.UP,2*PI/n*i), PI/6)
		#t = t.scaled_local( bar_size )
		multimesh.set_instance_transform(i,t )
		var rate := (i as float) / (n as float) *2
		if rate > 1 :
			rate = 2 - rate
		multimesh.set_instance_color(i,co1.lerp(co2,rate))

func _process(delta: float) -> void:
	change_visible_count()

var visible_count :int = 3
var count_inc :int = 1
func change_visible_count() -> void:
	visible_count += count_inc
	if visible_count > multimesh.instance_count:
		count_inc = -1
		visible_count = multimesh.instance_count
	if visible_count < 3:
		count_inc = 1
		visible_count = 3
	change_궤도(visible_count)
