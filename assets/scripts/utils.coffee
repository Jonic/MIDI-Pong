
calcSpeed = (speed) ->

	(speed * delta) * (60 / 1000)

random = (min, max) ->

	if min == undefined
		min = 0
		max = 1
	else if max == undefined
		max = min
		min = 0

	(Math.random() * (max - min)) + min;

randomInteger = (min, max) ->

	if max == undefined
		max = min
		min = 0

	Math.floor(Math.random() * (max + 1 - min)) + min