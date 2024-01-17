# Compute Shader Utils
## Functions
* `convert_array_to_bytes(array : Array) -> PackedByteArray` Takes in an array, and converts data into a single PackedByteArray.
* `extend_byte_array_to_memory_block(byte_array : PackedByteArray) -> PackedByteArray` Takes in a PackedByteArray of data, and extends length to fit in memory blocks (16 bytes).