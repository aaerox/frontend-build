###--------------------------------------------------- 
		Handles custom wysiwyg layout
---------------------------------------------------###
define "util/wysiwyg", [], () ->

	class Wysiwyg

		element: null


		constructor: (@element) ->
			@splitHeadings()


		splitHeadings: () ->
			elementTag = "<article class='#{@element.attr('class')}'></article>"
			currentWysiwyg = @element

			while true
				# Find the next header to split
				headerTag = $('h4', currentWysiwyg).eq(0)
				if headerTag.length == 0
					break

				# Split the WYSIWYG section at that point
				nextWysiwyg = $(elementTag)
				currentWysiwyg.after nextWysiwyg

				nextWysiwyg.append headerTag.nextAll()

				# Insert our header into it's own container
				headerTag.addClass 'wysiwyg-split-header'
				nextWysiwyg.before headerTag

				# Don't leave empty containers
				if currentWysiwyg.children().length == 0
					currentWysiwyg.remove()

				# Continue splitting
				currentWysiwyg = nextWysiwyg


		@parseAll: ->
			wysiwygElements = $('.wysiwyg')

			# Handle each of them
			wysiwygElements.each () ->
				new Wysiwyg($(this))

