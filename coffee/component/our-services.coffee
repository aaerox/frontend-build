###--------------------------------------------------- 
		Homepage 'our services' mobile-only carousel
---------------------------------------------------###
define "component/our-services", ["imagesloaded/imagesloaded"], (ImagesLoaded) ->

	class OurServices

		element: null


		constructor: (@element) ->
			new ImagesLoaded @element[0], =>
				@loadCarousel()


		loadCarousel: ->
			slides = $('.our-services__mobile', @element)

			slides.owlCarousel
				items: 1
				loop: true
				autoplay: true
				autoplayTimeout: 5000
				slideBy: 'page'
				nav: false
