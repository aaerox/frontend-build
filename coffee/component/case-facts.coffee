###--------------------------------------------------- 
		Case study facts mobile-only carousel
---------------------------------------------------###
define "component/case-facts", ["imagesloaded/imagesloaded"], (ImagesLoaded) ->

	class OurServices

		element: null


		constructor: (@element) ->
			new ImagesLoaded @element[0], =>
				@loadCarousel()


		loadCarousel: ->
			slides = $('.case-facts__mobile', @element)

			slides.owlCarousel
				items: 1
				loop: true
				autoHeight: true
				slideBy: 'page'
				nav: false

				onResize: ->
					# Keep autoheight behaving
					this.trigger('changed', { property: { name: 'position', value: this._current } });
