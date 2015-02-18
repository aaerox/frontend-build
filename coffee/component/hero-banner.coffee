###--------------------------------------------------- 
		Parallax-enabled hero banner
---------------------------------------------------###
define "component/hero-banner", ["imagesloaded/imagesloaded"], (ImagesLoaded) ->

	class HeroBanner

		element: null

		constructor: (@element) ->
			# Wait for the images to load
			new ImagesLoaded @element[0], =>
				@loadBanner()


		loadBanner: ->
			@element.addClass 'hero-banner--loaded'
