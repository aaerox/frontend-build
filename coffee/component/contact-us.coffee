###--------------------------------------------------- 
		Fixed contact-us widget
---------------------------------------------------###
define "component/contact-us", [], () ->

	class ContactUs

		element: null

		scrollDiv: null

		offset: 0


		constructor: (@element) ->
			@scrollDiv = $('.layout__content')
			
			@registerEvents()

			# Keep our position updated
			@layout()

			@scrollDiv.scroll => @layout()
			$(window).resize => @layout()

			# Reveal it
			@element.addClass 'contact-us--positioned'


		layout: ->
			@offset = @obtainPositionOffset()
			@updatePosition()


		obtainPositionOffset: ->
			# Add up the height of all dynamic elements
			offset = 0

			offset += $('.top-bar').outerHeight()
			offset += $('.header--small').outerHeight()
			offset += $('.hero-banner').outerHeight()
			offset += $('.sub-navigation').outerHeight()

			return offset


		updatePosition: ->
			# Keep up with the scrolling
			scrollTop = @scrollDiv.scrollTop()
			offset = Math.max(scrollTop, @offset)

			@element.css 'top', offset


		registerEvents: ->
			$('.contact-us__item', @element).on 'click', (e) =>
				e.stopPropagation()
				$(e.delegateTarget).addClass 'contact-us__item--open'

			# Clicking anything else will close it
			$('html').on 'click', =>
				$('.contact-us__item--open').removeClass 'contact-us__item--open'
