o = require 'observable'
o.compute = (observables,compute) ->
	cur = observables.map (e) -> e()
	init = true

	v = o()
	byes = observables.map (f,i) ->
		f (val) ->
			cur[i] = val
			return if init
			v compute cur...
	v compute cur...
	init = false	
	v.$destroy = ->
		byes.forEach (f) -> f()

	v

module.exports = o