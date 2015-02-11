###--------------------------------------------------- 
		Generic form container
---------------------------------------------------###
define "component/form", [], () ->

	class Form

		element: null


		constructor: (@element) ->
			@manageInputFills(true)

			$ =>
				@manageInputFills()
				@manageValidation()
				@manageSubmit()


		manageInputFills: (listenEvents = false) ->
			# Look after every input element which needs to be aware of whether it has content
			textFields = $('.form-text, .form-textarea', @element)
			textFields.each (i, val) =>
				@checkTextFill $(val)

			if listenEvents then textFields.on 'change', (e) =>
				@checkTextFill $(e.delegateTarget)
				if $(e.delegateTarget).data('trigger')?
					@checkTriggers $(e.delegateTarget)
			
			# Take care of dropdowns which have anything but default selected
			dropdowns = $('.form-dropdown', @element)
			dropdowns.each (i, val) =>
				@checkDropdownFill $(val)

			if listenEvents then dropdowns.on 'change', (e) =>
				@checkDropdownFill $(e.delegateTarget)
				if $(e.delegateTarget).data('trigger')?
					@checkTriggers $(e.delegateTarget)


		checkTextFill: (element) ->
			input = $('.form-text__input, .form-textarea__text', element)

			if element.hasClass 'form-text'
				if input.val() != ''
					element.addClass 'form-text--filled'
				else 
					element.removeClass 'form-text--filled'

			else if element.hasClass 'form-textarea'
				if input.val() != ''
					element.addClass 'form-textarea--filled'
				else 
					element.removeClass 'form-textarea--filled'


		checkDropdownFill: (element) ->
			select = $('.form-dropdown__select', element)

			if select[0].selectedIndex != 0
				element.addClass 'form-dropdown--selected'
			else
				element.removeClass 'form-dropdown--selected'


		manageValidation: ->
			# Watch for validation on every element
			$('.form__element', @element)
			.on 'change', (e) =>
				@validateElement $(e.delegateTarget)


		validateElement: (element) ->
			valid = true

			# Find all our validators
			validators = $('.form-error', element)
			validators.each (i, val) ->
				ValidatorValidate(val)

				if not val.isvalid
					$(val).addClass 'form-error--invalid'
				else
					$(val).removeClass 'form-error--invalid'

				if not val.isvalid 
					valid = false


			# Appropriately flag the element
			if not valid
				element.addClass 'form__element--invalid'
				element.removeClass 'form__element--valid'
			else
				element.removeClass 'form__element--invalid'
				element.addClass 'form__element--valid'


		manageSubmit: ->
			# Validate everything on submit
			$('.form__submit-button', @element)
			.on 'click', (e) =>
				$('.form__element', @element).each (i, val) =>
					@validateElement $(val)

				# Only allow the postback if our page is valid
				if Page.IsPostback
					Page.Validate()

					if not Page.isvalid
						e.preventDefault()


		checkTriggers: (element) ->
			triggered = false
			triggers = element.data('trigger')

			if triggers.idx?
				numOptions = $('.form-dropdown__select', element).find('option').length
				selectedIndex = $('.form-dropdown__select', element).find(':selected').index()

				if (triggers.idx == -1 and selectedIndex == numOptions - 1) or selectedIndex == triggers.idx
					triggered = true

			if triggered 
				$(triggers.target, @element).addClass 'form-trigger--visible'
			else
				$(triggers.target, @element).removeClass 'form-trigger--visible'






			
