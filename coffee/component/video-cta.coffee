###--------------------------------------------------- 
		Generic video CTA
---------------------------------------------------###
define "component/video-cta", ["magnific-popup/jquery.magnific-popup"], (MagnificPopup) ->

	class VideoCTA

		element: null

		href: null


		@DISABLE_BREAKPOINT: 700


		constructor: (@element) ->
			# Do we have a video attached?
			vimeo = @element.data 'vimeo'
			youtube = @element.data 'youtube'

			if vimeo?
				@loadVimeo(vimeo)
			else if youtube?
				@loadYoutube(youtube)

			if vimeo? or youtube?
				@element.on 'click', (e) =>
					if $(window).width() <= VideoCTA.DISABLE_BREAKPOINT
						window.location.href = @href


		loadVimeo: (id) ->
			@href = "//player.vimeo.com/video/#{id}"

			@element.magnificPopup
				type: 'iframe'
				items:
					src: @href
				disableOn: VideoCTA.DISABLE_BREAKPOINT,
				mainClass: 'mfp-fade',
				removalDelay: 160,
				preloader: false,
				fixedContentPos: false

			@element.addClass 'cta--video-ready'
				


		loadYoutube: (id) ->
			@href = "//www.youtube.com/watch?v=#{id}"

			@element.magnificPopup
				type: 'iframe'
				items:
					src: @href
				disableOn: VideoCTA.DISABLE_BREAKPOINT,
				mainClass: 'mfp-fade',
				removalDelay: 160,
				preloader: false,
				fixedContentPos: false

			@element.addClass 'cta--video-ready'
