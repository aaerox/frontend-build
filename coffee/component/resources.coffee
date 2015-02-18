###--------------------------------------------------- 
		Enables video content in the resources listing
---------------------------------------------------###
define "component/resources", ["magnific-popup/jquery.magnific-popup"], (MagnificPopup) ->

	class Resources

		element: null

		href: null


		@DISABLE_BREAKPOINT: 700


		constructor: (@element) ->
			# Initialize video elements
			$('[data-vimeo]', @element).each (i, val) =>
				@loadVimeo $(val)

			$('[data-youtube]', @element).each (i, val) =>
				@loadYoutube $(val)


		loadVimeo: (element) ->
			id = element.data('vimeo')
			href = "//player.vimeo.com/video/#{id}"

			element.magnificPopup
				type: 'iframe'
				items:
					src: href
				disableOn: Resources.DISABLE_BREAKPOINT,
				mainClass: 'mfp-fade',
				removalDelay: 160,
				preloader: false,
				fixedContentPos: false

			element.addClass 'resources__item--video-ready'

			element.on 'click', (e) =>
				if $(window).width() <= Resources.DISABLE_BREAKPOINT
					window.location.href = href
				

		loadYoutube: (element) ->
			id = element.data('youtube')
			href = "//www.youtube.com/watch?v=#{id}"

			element.magnificPopup
				type: 'iframe'
				items:
					src: href
				disableOn: Resources.DISABLE_BREAKPOINT,
				mainClass: 'mfp-fade',
				removalDelay: 160,
				preloader: false,
				fixedContentPos: false

			element.addClass 'resources__item--video-ready'

			element.on 'click', (e) =>
				if $(window).width() <= Resources.DISABLE_BREAKPOINT
					window.location.href = href
