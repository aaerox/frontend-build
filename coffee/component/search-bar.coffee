###--------------------------------------------------- 
		Search results page bar
---------------------------------------------------###
define "component/search-bar", [], () ->

	class SearchBar

		element: null


		constructor: (@element) ->
			@checkTextFill @element

			@element.on 'change', (e) =>
				@checkTextFill @element


		checkTextFill: (element) ->
			input = $('.search-bar__text', element)

			if input.val() != ''
				element.addClass 'search-bar--filled'
			else 
				element.removeClass 'search-bar--filled'
