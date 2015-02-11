###--------------------------------------------------- 
		Mobile-only page sub-nav
---------------------------------------------------###
define "component/mobile-sub-nav", [], () ->

	class MobileSubNav

		element: null


		constructor: (@element) ->
			$('.mobile-sub-nav__parent', @element).on 'click', (e) =>
				if @navClicked($(e.delegateTarget).attr('href'))
					e.preventDefault()


		navClicked: (link) ->
			mobileNav = @getMobileNav()
			
			# Does it contain this link?
			if mobileNav.hasLink(link)
				mobileNav.navigateTo(link)
				return true

			return false


		getMobileNav: ->
			mobileNav = $('.mobile-nav').get(0)
			return mobileNav.component
