extends VoxelGenerator

var amplitude:float = 10.0
var period:Vector2 = Vector2(1/10.0, 1/10.0)

export var channel:int = VoxelBuffer.CHANNEL_SDF

func get_used_channels_mask () -> int:
	return 1<<channel
	
func generate_block(out_buffer:VoxelBuffer, origin:Vector3, lod:int) -> void:

# Draw on LOD 0 just for testing. Look in C++ noise generators to see how LODs are calculated.
	if lod > 0:
		return

# Draw a flat plane at origin.y == 0
#	if origin.y < 0: 
#		out_buffer.fill(1, channel)
#		return
		
# Draw 3D sine waves	
	var size = out_buffer.get_size()
	for rz in range(0, size.z):
		for rx in range(0, size.x):
			var x:float = origin.x + rx
			var z:float = origin.z + rz

			var h:int = amplitude * (cos(x * period.x) + sin(z * period.y)) # Y is correct
			var rh:int = h - origin.y
			if rh > size.y:
				rh = size.y

			for ry in range(0, rh):
				out_buffer.set_voxel(1, rx, ry, rz, channel);
