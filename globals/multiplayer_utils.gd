class_name MultiplayerUtils

#this is similar to multiplayer.get_peers(), but includes the local client's unique ID.
static func get_connected_peer_ids(multiplayer : MultiplayerAPI) -> PackedInt32Array:
	var peers : PackedInt32Array = multiplayer.get_peers()
	
	#add server to peer ID list
	if not OS.has_feature("server"):
		#PackedInt32Array doesn't have `push_front()`, so we must do this workaround
		peers = PackedInt32Array([multiplayer.get_unique_id()]) + peers
	
	return peers

static func get_total_peers(multiplayer : MultiplayerAPI) -> int:
	return get_connected_peer_ids(multiplayer).size()

static func get_self_peer_id(multiplayer : MultiplayerAPI) -> int:
	return multiplayer.get_unique_id()
