extends Node

#in seconds
var last_ping : float = 0.0

#server only value,
#{int player_id : float ping}
var ping_dictionary : Dictionary = {}

func _physics_process(delta : float) -> void:
	if !multiplayer.has_multiplayer_peer() or !multiplayer.is_server():
		return
	#ping everyone
	ping.rpc(Time.get_ticks_msec())
	receive_ping_dictionary.rpc(ping_dictionary)

#called on host and client
@rpc(call_local, any_peer, unreliable_ordered)
func ping(server_time : int) -> void:
	if multiplayer.get_remote_sender_id() != 1:
		return
	#return time to server
	pong.rpc_id(1, server_time)

#called on host
@rpc(call_local, any_peer, unreliable_ordered)
func pong(returned_time : int) -> void:
	var elapsed_time : float = float(Time.get_ticks_msec() - returned_time) / 2000.0
	ping_dictionary[multiplayer.get_remote_sender_id()] = elapsed_time
	receive_ping.rpc_id(multiplayer.get_remote_sender_id(), elapsed_time)

#called on host and client
#notify of pings
@rpc(call_local, any_peer, unreliable_ordered)
func receive_ping(received_ping : float) -> void:
	if multiplayer.get_remote_sender_id() != 1:
		return
	last_ping = received_ping

@rpc(call_local, any_peer, unreliable_ordered)
func receive_ping_dictionary(ping_dictionary : Dictionary) -> void:
	if multiplayer.get_remote_sender_id() != 1:
		return
	ping_dictionary = ping_dictionary
