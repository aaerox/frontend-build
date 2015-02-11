###--------------------------------------------------- 
		Used to control the mobile navigation
---------------------------------------------------###
define "component/mobile-nav", ["nanoscroller/jquery.nanoscroller"], () ->

	class MobileNav

		element: null

		layout: null

		isTransitioning: false

		lastHeight: 0

		# Constants
		@TRANSITION_DURATION: 200
		@COLLAPSE_DELAY: 150
		@EXPAND_DELAY: 150


		constructor: (@element) ->
			@layout = $('.layout')

			$('.scrollable', @element).nanoScroller
				paneClass: 'scrollable__pane'
				sliderClass: 'scrollable__slider'
				contentClass: 'scrollable__content'

			@registerEvents()


		registerEvents: ->
			$('.mobile-nav__search, .mobile-nav__search-close').on 'click', (e) =>
				e.preventDefault()
				@toggleSearchMenu()

			$('.mobile-nav__close', @element).on 'click', (e) =>
				e.preventDefault()
				@toggleMenu()

			$('.mobile-nav__link', @element).on 'click', (e) =>
				item = $(e.delegateTarget).closest('.mobile-nav__item')

				# Are we browsing to another level?
				if $('.mobile-nav__items', item).length > 0
					e.preventDefault()
					@toggleNestedMenu item

			# Naughty, but listen out of scope for our nav button
			$('.header__hamburger').on 'click', (e) =>
				e.preventDefault()
				@toggleMenu()


		toggleMenu: ->
			if @isTransitioning
				return

			hamburgerLayer = $('header__hamburger .hamburger__layer')

			if @layout.hasClass 'layout--pushed'
				@layout.removeClass 'layout--pushed'

			else
				@resetMenu()
				@layout.addClass 'layout--pushed'


		toggleSearchMenu: ->
			if @isTransitioning
				return

			header = $('.mobile-nav__header', @element)
			header.toggleClass 'mobile-nav__header--searching'

			if header.hasClass 'mobile-nav__header--searching'
				searchText = $('.search__text', @element)

				searchText.val ''
				searchText.focus()


		toggleNestedMenu: (item, transitionDuration = MobileNav.TRANSITION_DURATION) ->
			if @isTransitioning
				return

			itemParent = item.parents('.mobile-nav__item--open').find('> .mobile-nav__element')
			listParent = item.closest('.mobile-nav__items')
			siblings = $('> .mobile-nav__item', listParent).filter ->
				return $(this)[0] != item[0]

			excluded = itemParent.add(siblings)

			# Trigger the element style change
			@isTransitioning = true
			
			if not item.hasClass 'mobile-nav__item--open'
				item.addClass 'mobile-nav__item--open'

				# Expand our subitems
				$('> .mobile-nav__items', item).slideDown transitionDuration

				# Hide all other items on this level
				excluded.filter('.mobile-nav__element').addClass 'mobile-nav__element--hide'
				excluded.filter('.mobile-nav__item').addClass 'mobile-nav__item--hide'

				# Collapse all other excluded elements after a short delay
				setTimeout =>
					@lastHeight = excluded.outerHeight()

					excluded.stop(true).animate { height: 0 }, transitionDuration, =>
						@isTransitioning = false
				, MobileNav.COLLAPSE_DELAY

			else
				# Contract our subitems
				$('> .mobile-nav__items', item).slideUp()

				# Display our excluded elements once again
				setTimeout =>
					excluded.each (i, val) =>
						excludedItem = $(val)

						excludedItem.stop(true).animate { height: @lastHeight }, transitionDuration, ->
							$(this).css 'height', ''

				, MobileNav.EXPAND_DELAY

				setTimeout =>
					@isTransitioning = false

					item.removeClass 'mobile-nav__item--open'

					excluded.removeClass 'mobile-nav__element--hide'
					excluded.removeClass 'mobile-nav__item--hide'

				, transitionDuration + MobileNav.EXPAND_DELAY


		resetMenu: ->
			$('*', @element).css 'height', ''

			$('.mobile-nav__item--open', @element).each (i, val) ->
				$('> .mobile-nav__items', this).slideUp 0

			$('.mobile-nav__item--open', @element).removeClass 'mobile-nav__item--open'
			$('.mobile-nav__item--hide', @element).removeClass 'mobile-nav__item--hide'
			$('.mobile-nav__element--hide', @element).removeClass 'mobile-nav__element--hide'
				

		hasLink: (link) ->
			return $(".mobile-nav__link[href='#{link}']", @element).length > 0


		navigateTo: (link) ->
			# Open our navigation
			@toggleMenu()

			# Find the relevant item
			candidates = $(".mobile-nav__link[href='#{link}']", @element).closest('.mobile-nav__item')
			candidates = candidates.filter -> $(this).find('> .mobile-nav__items').length > 0

			# Open it!
			item = candidates.eq(0)
			@toggleNestedMenu item, 0

			# Set up any parents
			parents = item.parents('.mobile-nav__item')

			$('> .mobile-nav__items', parents).css 'display', 'block'
			$('> .mobile-nav__element', parents).css 'height', '0px'

			parents.siblings().css 'height', '0px'

			parents.addClass 'mobile-nav__item--open'

