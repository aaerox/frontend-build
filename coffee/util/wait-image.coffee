###--------------------------------------------------- 
		Waits for images to load and appends a class
---------------------------------------------------###
define "util/wait-image", ["imagesloaded/imagesloaded"], (ImagesLoaded) ->

	class WaitImage

		element: null


		constructor: (@element) ->
			new ImagesLoaded @element[0], =>
				loadClass = @element.data 'wait-image'
				@element.addClass loadClass


		@waitAll: ->
			waitElements = $('*[data-wait-image]')

			# Load the images for each
			waitElements.each () ->
				new WaitImage($(this))

