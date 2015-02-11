###--------------------------------------------------- 
		Homepage 'our clients' carousel
---------------------------------------------------###
define "component/our-clients", ["imagesloaded/imagesloaded"], (ImagesLoaded) ->

	class OurClients

		element: null


		constructor: (@element) ->
			new ImagesLoaded @element[0], =>
				@loadCarousel()


		loadCarousel: ->
			slides = $('.our-clients__clients', @element)

			slides.owlCarousel
				items: 5
				loop: true
				autoplay: true
				autoplayTimeout: 5000
				slideBy: 'page'
				nav: false
				responsiveRefreshRate: 0
				responsive:
					0:
						items: 1
					360:
						items: 2
					450:
						items: 3
					768:
						items: 4
					900:
						items: 5
				onInitialized: => @normalizeHeights()
			
			$(window).resize => @normalizeHeights()


		normalizeHeights: ->
			maxHeight = 0
			items = $('.owl-item', @element)
			items.css 'height', ''

			items.each ->
				height = $(this).outerHeight()
				maxHeight = Math.max(height, $(this).outerHeight())

			items.height maxHeight
