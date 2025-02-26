class_name MultiplayerUtils


## Similar to [code]MultiplayerAPI.get_peers()[/code], but it will includes the local client's peer ID, 
## unless the current build has the [code]server[/code] feature tag.
static func get_connected_peer_ids(multiplayer : MultiplayerAPI) -> PackedInt32Array:
	var peers : PackedInt32Array = multiplayer.get_peers()
	
	#add server to peer ID list
	if not OS.has_feature("server"):
		#PackedInt32Array doesn't have `push_front()`, so we must do this workaround
		peers = PackedInt32Array([multiplayer.get_unique_id()]) + peers
	
	return peers

## Returns the amount of connected peers, including the local client, 
## unless the current build has the [code]server[/code] feature tag.
static func get_total_peers(multiplayer : MultiplayerAPI) -> int:
	return get_connected_peer_ids(multiplayer).size()

## Alias for [code]MultiplayerAPI.get_unique_id()[/code]
static func get_self_peer_id(multiplayer : MultiplayerAPI) -> int:
	return multiplayer.get_unique_id()
