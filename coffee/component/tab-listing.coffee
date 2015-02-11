###--------------------------------------------------- 
		Generic tabbed container WYSIWYG control
---------------------------------------------------###
define "component/tab-listing", [], () ->

	class TabListing

		element: null

		# Constants
		@TRANSITION_DELAY: 200


		constructor: (@element) ->
			@registerEvents()

			# Select our first tab
			$('.tab-listing__item', @element).eq(0).addClass 'tab-listing__item--active'
			@selectTab(0)

			# Mark it as initialized
			@element.removeClass 'tab-listing--uninitialized'


		selectTab: (index) ->
			# Select the correct tab
			$('.tab-listing__tab', @element).removeClass 'tab-listing__tab--active'
			$('.tab-listing__tab', @element).eq(index).addClass 'tab-listing__tab--active'

			# Select the relevant content
			currentContent = $('.tab-listing__item--active', @element)

			if currentContent.length > 0
				currentContent.stop(true).fadeOut TabListing.TRANSITION_DELAY, =>
					currentContent.removeClass 'tab-listing__item--active'

					@selectContent(index)

			else 
				@selectContent(index)


		selectContent: (index) ->
			content = $('.tab-listing__item', @element).eq(index)
			content.addClass 'tab-listing__item--active'

			content.stop(true).fadeIn TabListing.TRANSITION_DELAY


		registerEvents: ->
			$('.tab-listing__tab', @element).on 'click', (e) =>
				tab = $(e.delegateTarget)

				if not tab.hasClass 'tab-listing__tab--active'
					@selectTab tab.index()	
