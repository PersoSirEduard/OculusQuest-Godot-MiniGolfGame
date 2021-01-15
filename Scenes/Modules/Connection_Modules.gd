tool
extends Spatial

export(bool) var Generate_Meshes = false setget set_gen_mesh

func set_gen_mesh(val):
	if val == true:
		val = false
		var dir = Directory.new()
		dir.open(self.get_script().get_path().get_base_dir())
		dir.make_dir("Exports")
		print("'Exports' folder created.")
		var path = self.get_script().get_path().get_base_dir() + "/Exports/"
		
		for node in get_children():
			if ClassDB.is_parent_class(node.get_class(),"CSGCombiner"):
				node._update_shape()
				var new_mesh = MeshInstance.new()
				new_mesh.mesh = node.get_meshes()[1]
				new_mesh.create_trimesh_collision()
				#new_mesh.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_ON
				var exportScene = PackedScene.new()
				var result = exportScene.pack(new_mesh)
				if result == OK:
					if (not dir.file_exists("Exports/" + node.name + ".tscn")):
						ResourceSaver.save(path + node.name + ".tscn", exportScene)
						print("Created and saved " + node.name + " mesh.")
				else:
					print("Error. Could not create a mesh for " + node.name)
					pass
		print("Done.")
		
