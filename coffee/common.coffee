###--------------------------------------------------- 
		Houses common page functionality
---------------------------------------------------###
define "common", ["util/wysiwyg", "util/wait-image", "util/wait-visible", "fastclick/fastclick"], (Wysiwyg, WaitImage, WaitVisible, FastClick) ->

	$('html').removeClass 'no-js'
	
	# Initialize fastclick
	FastClick.attach(document.body)

	# Handle custom wysiwyg content
	Wysiwyg.parseAll()
	
	# Handle loading triggers
	WaitImage.waitAll()
	WaitVisible.waitAll()
