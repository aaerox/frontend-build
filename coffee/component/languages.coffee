###--------------------------------------------------- 
		Language selector dropdown
---------------------------------------------------###
define "component/languages", [], () ->

	class Languages

		element: null


		constructor: (@element) ->
			# Toggle
			@element.on 'click', (e) =>
				if $(e.currentTarget).closest('.languages__dropdown').length == 0
					@element.toggleClass 'languages--open'
