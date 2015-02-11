###--------------------------------------------------- 
		Generic expandable list with 'Read more' link
---------------------------------------------------###
define "component/expandable-list", [], () ->

	class ExpandableList

		element: null


		constructor: (@element) ->
			# Get our configuration variables
			limit = parseInt(@element.data('expandable-limit'))

			itemClass = @element.data 'expandable-item'
			collapsedClass = @element.data 'expandable-collapse'
			moreClass = @element.data 'expandable-more'

			itemElement = $(".#{itemClass}", @element)
			collapsedElement = $(".#{collapsedClass}", @element)
			moreElement = $(".#{moreClass}", @element)
			
			# Enough elements?
			if itemElement.length <= limit
				moreElement.hide()
				return

			if collapsedElement.length == 0 or moreElement.length == 0
				return

			# Listen for a click, and then act
			moreElement.on 'click', ->
				moreElement.hide()
				collapsedElement.removeClass collapsedClass
