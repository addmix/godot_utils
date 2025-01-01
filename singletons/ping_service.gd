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
	
	#this should be sent less often.
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

#we should probably clarify naming that this is total ping between ourselves and the target peer ID
func get_ping(id : int) -> float:
	var total_ping : float = ping + ping_dictionary.get(id, -0.0)
	
	if id == multiplayer.get_unique_id():
		ping = 0.0
	
	#use -0.0 as an indicator that no ping was available
	#return ping_dictionary.get(id, -0.0)
	return total_ping

func on_peer_connected(id : int) -> void:
	ping_dictionary[id] = 0.0

#this function calls an RPC, trying to accommodate ping.
#delay_time is how long, in seconds, to wait before the function should execute
#if delay_time is lower than a peer's latency, they will be desynced.
#function is the function to be called, which must be configured as an RPC.
#params are any parameters for the function to be RPC'd
func rpc_reliable_timing(delay_time : float, function : Callable, params : Array = []) -> void:
	print("starting rpc")
	for peer_id : int in MultiplayerUtils.get_connected_peer_ids(multiplayer):
		var rpc_latency : float = ping + get_ping(peer_id)
		#ping to self is 0
		#this could be wrong if RPCs configured with call_local still propagate from client to server, back to client.
		if peer_id == multiplayer.get_unique_id():
			rpc_latency = 0.0
		
		var time_to_wait : float = delay_time - rpc_latency
		
		var delayed_rpc : Callable = func(time_to_delay : float, peer_id : int):
			await get_tree().create_timer(time_to_wait).timeout
			print("calling rpc for peer ", peer_id)
			var function_with_arguments_bound := function.bindv(params)
			function_with_arguments_bound.rpc_id(peer_id)
		
		delayed_rpc.call(time_to_wait, peer_id)
