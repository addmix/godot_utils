extends Node

#in seconds
var ping : float = 0.0

#server only value,
#{int player_id : float ping}
var ping_dictionary : Dictionary = {}

func _ready() -> void:
	get_tree().get_multiplayer().peer_connected.connect(on_peer_connected)

func _physics_process(delta : float) -> void:
	if !multiplayer.has_multiplayer_peer() or !multiplayer.is_server():
		return
	#ping everyone
	_ping.rpc(Time.get_ticks_msec())
	receive_ping_dictionary.rpc(ping_dictionary)

#called on host and client
@rpc("call_local", "any_peer", "unreliable_ordered")
func _ping(server_time : int) -> void:
	if multiplayer.get_remote_sender_id() != 1:
		return
	#return time to server
	_pong.rpc_id(1, server_time)

#called on host
@rpc("call_local", "any_peer", "unreliable_ordered")
func _pong(returned_time : int) -> void:
	var elapsed_time : float = float(Time.get_ticks_msec() - returned_time) / 2000.0
	ping_dictionary[multiplayer.get_remote_sender_id()] = elapsed_time
	_receive_ping.rpc_id(multiplayer.get_remote_sender_id(), elapsed_time)

#called on host and client
#notify of pings
@rpc("call_local", "any_peer", "unreliable_ordered")
func _receive_ping(received_ping : float) -> void:
	if multiplayer.get_remote_sender_id() != 1:
		return
	ping = received_ping

@rpc("call_local", "any_peer", "unreliable_ordered")
func receive_ping_dictionary(ping_dictionary : Dictionary) -> void:
	if multiplayer.get_remote_sender_id() != 1:
		return
	ping_dictionary = ping_dictionary

func get_ping(id : int) -> float:
	return ping_dictionary[id]

func on_peer_connected(id : int) -> void:
	ping_dictionary[id] = 0.0
