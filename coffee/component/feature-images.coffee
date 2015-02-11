###--------------------------------------------------- 
		Standard image carousel
---------------------------------------------------###
define "component/feature-images", ["imagesloaded/imagesloaded"], (ImagesLoaded) ->

	class FeatureImages

		element: null


		constructor: (@element) ->
			new ImagesLoaded @element[0], =>
				@loadCarousel()


		loadCarousel: ->
			slides = $('.feature-images__items', @element)

			slides.owlCarousel
				items: 1
				loop: true
				autoHeight: true
				slideBy: 'page'
				nav: true
				navText:['', '']

				onResize: ->
					# Keep autoheight behaving
					this.trigger('changed', { property: { name: 'position', value: this._current } });
