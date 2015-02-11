###--------------------------------------------------- 
		Expandable text field on the staff listing page
---------------------------------------------------###
define "component/staff-listing-item", [], () ->

	class StaffListingItem

		element: null


		constructor: (@element) ->
			# Is the summary div long enough to be collapsed?
			summaryHeight = $('.staff-listing__summary', @element).height()

			if summaryHeight > 200 
				@element.addClass 'staff-listing__item--collapsed'

			# Listen for events
			$('.staff-listing__more', @element).on 'click', =>
				@element.removeClass 'staff-listing__item--collapsed'
