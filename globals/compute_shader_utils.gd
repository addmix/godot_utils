class_name ComputeShaderUtils

#compute shader memory is in block of 16 bytes, and it is necessary to
static func extend_byte_array_to_memory_block(byte_array : PackedByteArray) -> PackedByteArray:
	var filler_bytes := PackedByteArray([])
	var remainder_bytes : int = byte_array.size() % 16
	if remainder_bytes == 0:
		return byte_array
	var bytes_to_fill : int = 16 - remainder_bytes
	for i in bytes_to_fill:
		byte_array.append(0)
	return byte_array

static func convert_array_to_bytes(array : Array) -> PackedByteArray:
	var bytes := PackedByteArray([])
	for item in array:
		match typeof(item):
			TYPE_BOOL:
				bytes += PackedInt32Array([item]).to_byte_array()
			TYPE_INT:
				bytes += PackedInt32Array([item]).to_byte_array()
			TYPE_VECTOR2I:
				bytes += PackedInt32Array([item.x, item.y]).to_byte_array()
			TYPE_VECTOR3I:
				bytes += PackedInt32Array([item.x, item.y, item.z]).to_byte_array()
			TYPE_VECTOR4I:
				bytes += PackedInt32Array([item.x, item.y, item.z, item.w]).to_byte_array()
			TYPE_FLOAT:
				bytes += PackedFloat32Array([item]).to_byte_array()
			TYPE_VECTOR2:
				bytes += PackedFloat32Array([item.x, item.y]).to_byte_array()
			TYPE_VECTOR3:
				bytes += PackedFloat32Array([item.x, item.y, item.z]).to_byte_array()
			TYPE_VECTOR4:
				bytes += PackedFloat32Array([item.x, item.y, item.z, item.w]).to_byte_array()
			TYPE_COLOR:
				bytes += PackedFloat32Array([item.r, item.g, item.b, item.a]).to_byte_array()

	bytes = extend_byte_array_to_memory_block(bytes)
	return bytes
