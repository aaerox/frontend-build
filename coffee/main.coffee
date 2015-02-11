###--------------------------------------------------- 
		Our app entrypoint which crawls the DOM for components
---------------------------------------------------###
define [], () ->

	# Execute common tasks
	require ["common"]
	
	# Search the DOM for all required components
	components = $('*[data-component]')

	# Load the component for each
	components.each () ->
		component = $(this).attr('data-component')
		require [component], (compClass) =>
			this.component = new compClass($(this))

# Trigger our application
require ["main"]
