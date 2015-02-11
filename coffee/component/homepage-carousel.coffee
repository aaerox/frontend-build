###--------------------------------------------------- 
		Controls the custom two-image carousel on the homepage
---------------------------------------------------###
define "component/homepage-carousel", ["requestAnimationFrame/requestAnimationFrame"], (requestAnimationFrame) ->

	class HomepageCarousel

		element: null

		carousel: null

		carouselHeight: 0

		images: null

		imageBackgrounds: null

		oldImage: null

		oldBackgroundImage: null

		currentImage: null

		currentBackgroundImage: null

		currentIndex: -1

		isAnimating: false

		# Constants
		@TRANSITION_DURATION: 600
		@BACKGROUND_DELAY: 100
		@OVERLAY_DELAY: 400


		constructor: (@element) ->
			# Adjust delays for IE9
			if $('.ie9').length > 0
				HomepageCarousel.TRANSITION_DURATION = 20
				HomepageCarousel.BACKGROUND_DELAY = 20
				HomepageCarousel.OVERLAY_DELAY = 20

			# Handle our carousel assets
			@extractImages()
			@loadBackgrounds()

			@registerEvents()

			carousel = null
			slides = $('.homepage-carousel__slides', @element)

			slides.owlCarousel
				items: 1
				autoHeight: true
				nav: true
				navText:['', '']
				smartSpeed: HomepageCarousel.TRANSITION_DURATION + HomepageCarousel.BACKGROUND_DELAY
				responsiveRefreshRate: 20
				
				onInitialize: ->
					carousel = this

				onInitialized: =>
					@carousel = carousel

				onResize: =>
					@carousel.trigger('changed', { property: { name: 'position', value: @carousel._current } });

				onResized: =>
					@carouselHeight = @element.outerHeight()

				onDrag: =>
					@element.addClass 'homepage-carousel--dragging'
					@beginAnimation()

				onDragged: =>
					@element.removeClass 'homepage-carousel--dragging'
					@endAnimation()

				onChanged: =>
					index = carousel.normalize(carousel.current())
					if index? and index != @currentIndex
						@slideChanged index



		extractImages: ->
			@images = []

			$('.homepage-carousel__image', @element).each (i, val) =>
				image = $(val).detach()

				@images.push image


		loadBackgrounds: ->
			@imageBackgrounds = []

			$('.homepage-carousel__figure', @element).each (i, val) =>
				background = $(val).data 'background'

				# Preload it
				image = new Image()
				image.src = background

				# Create a background image div
				$image = $('<div class="homepage-carousel__bgimage"></div>')
				$image.css 'background-image', "url(#{background})"

				@imageBackgrounds.push $image
			

		registerEvents: ->


		slideChanged: (index) ->
			# Update our arrow states
			first = index == 0
			last = index == @images.length - 1

			if first
				$('.owl-prev', @element).addClass 'disabled'
			else
				$('.owl-prev', @element).removeClass 'disabled'

			if last
				$('.owl-next', @element).addClass 'disabled'
			else
				$('.owl-next', @element).removeClass 'disabled'

			# Load in the image!
			@loadImage index


		loadImage: (index) ->
			if index == @currentIndex
				return

			@oldImage = @currentImage
			@oldBackgroundImage = @currentBackgroundImage

			@currentIndex = index

			# Attach our images to the dom
			image = @images[index]
			image.appendTo @element
			image.removeClass 'homepage-carousel__image--hide'
			image.css 'opacity', ''

			imageBackground = @imageBackgrounds[index]
			imageBackground.prependTo @element

			@currentImage = null
			@currentBackgroundImage = null

			# Take care of any ongoing animation
			@endAnimation()

			# Animate in and assign our image
			setTimeout =>
				imageBackground.addClass 'homepage-carousel__bgimage--show'
			, HomepageCarousel.BACKGROUND_DELAY

			setTimeout =>
				image.addClass 'homepage-carousel__image--show'
			, HomepageCarousel.OVERLAY_DELAY

			@currentImage = image
			@currentBackgroundImage = imageBackground


		beginAnimation: ->
			@isAnimating = true

			@tickAnimation()


		tickAnimation: ->
			if not @isAnimating or not @currentImage?
				return

			progress = Math.abs(@carousel.drag.distance) / ($(window).width() * 0.8)
			@currentImage.css 'opacity', Math.max(1 - (progress * 2), 0)

			requestAnimationFrame => @tickAnimation()


		endAnimation: ->
			@isAnimating = false

			# Remove any old images
			if @oldImage?
				image = @oldImage

				image.removeClass 'homepage-carousel__image--show'
				image.addClass 'homepage-carousel__image--hide'
				image.css 'opacity', ''

				setTimeout =>
					image.detach()
				, HomepageCarousel.TRANSITION_DURATION

				@oldImage = null

			# Remove any old background images
			if @oldBackgroundImage?
				imageBackground = @oldBackgroundImage

				setTimeout =>
					imageBackground.removeClass 'homepage-carousel__bgimage--show'
				, HomepageCarousel.BACKGROUND_DELAY

				setTimeout =>
					imageBackground.detach()
				, HomepageCarousel.BACKGROUND_DELAY + HomepageCarousel.TRANSITION_DURATION

				@oldBackgroundImage = null

			# Be sure that our current image is completely visible
			if @currentImage?
				@currentImage.addClass 'homepage-carousel__image--show'
				@currentImage.css 'opacity', ''


