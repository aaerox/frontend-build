###--------------------------------------------------- 
		Waits elements to be shown on the page
---------------------------------------------------###
define "util/wait-visible", ["waypoints", "waypoints.inview"], () ->

	class WaitVisible

		element: null


		constructor: (@element) ->
			waypoint = new Waypoint.Inview
				element: @element[0]
				entered: (direction) =>
					visibleClass = @element.data 'wait-visible'
					@element.addClass visibleClass


		@waitAll: ->
			waitElements = $('*[data-wait-visible]')

			# Load the images for each
			waitElements.each () ->
				new WaitVisible($(this))

			# Feed the scroll event to waypoints
			$('.layout__content').scroll -> Waypoint.refreshAll()


