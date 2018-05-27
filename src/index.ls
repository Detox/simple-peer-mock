/**
 * @package simple-peer-mock
 * @author  Nazar Mokrynskyi <nazar@mokrynskyi.com>
 * @license 0BSD
 */
simple-peer-instances	= []
async-eventer			= require('async-eventer')

!function simple-peer-mock (options)
	if !(@ instanceof simple-peer-mock)
		return new simple-peer-mock(options)
	async-eventer.call(@)

	@_initiator	= options.initiator
	@_own_id	= simple-peer-instances.length
	simple-peer-instances.push(@)

	if options.initiator
		setTimeout (!~>
			@fire('signal', {
				type	: 'offer'
				sdp		: String(@_own_id)
			})
		)

simple-peer-mock:: =
	signal : (signal) !->
		if @_initiator && signal['type'] != 'answer'
			@destroy()
			return
		if !@_initiator && signal['type'] != 'offer'
			@destroy()
			return
		@_target_id	= +signal['sdp']
		if '_target_id' of simple-peer-instances[@_target_id]
			@fire('connect')
			simple-peer-instances[@_target_id].fire('connect')
		else if !@_initiator
			@fire('signal', {
				type	: 'answer'
				sdp		: String(@_own_id)
			})

	send : (data) !->
		simple-peer-instances[@_target_id].fire('data', data)
	destroy : ->
		if @_destroyed
			return
		@_destroyed	= true
		@fire('close')

simple-peer-mock:: = Object.assign(Object.create(async-eventer::), simple-peer-mock::)
Object.defineProperty(simple-peer-mock::, 'constructor', {value: simple-peer-mock})

module.exports	=
	simple-peer-mock	: simple-peer-mock
	register			: !->
		# This is brutal, but running full WebRTC implementation for testing purposes is not feasible
		module						= require('module')
		original_require			= module.prototype.require
		module.prototype.require	= (module_name) ->
			if module_name == '@detox/simple-peer'
				simple-peer-mock
			else
				original_require.apply(this, arguments)
