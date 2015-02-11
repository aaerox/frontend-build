###--------------------------------------------------- 
		Google map component
---------------------------------------------------###
define "component/map", ["async!http://maps.google.com/maps/api/js?sensor=false"], () ->

	class Map

		element: null

		map: null

		locations: []

		markers: []

		@MAP_COUNT: 0

		@DEFAULT_OPTIONS:
			draggable: false
			scrollwheel: false
			disableDefaultUI: true


		constructor: (@element) ->
			# Load our location data
			locations = @element.data 'locations'
			if not locations?
				@element.remove()
				return

			@locations = locations.Results

			# Load and initialize the map itself
			@initializeMap()
			@addMarkers()
			@fitMarkerBounds()


		initializeMap: ->
			# Create our map element
			Map.MAP_COUNT++

			mapDiv = $('<div></div>')
			.attr 'class', 'google-map__map'
			.attr 'id', "map#{Map.MAP_COUNT}"
			.appendTo @element

			# Load google maps
			mapOptions = Map.DEFAULT_OPTIONS

			@map = new google.maps.Map mapDiv.get(0), mapOptions


		addMarkers: ->
			@markers = []

			# Create and add each marker
			for location in @locations
				coord = new google.maps.LatLng parseFloat(location.coordinate[1]), parseFloat(location.coordinate[0])

				marker = new google.maps.Marker
					position: coord
					title: location.title
					map: @map

				@markers.push marker


		fitMarkerBounds: =>
			latLngBounds = new google.maps.LatLngBounds()

			for marker, i in @markers
				latLngBounds.extend marker.getPosition()
				if i == 0
					@map.setCenter marker.getPosition()

			@map.setCenter latLngBounds.getCenter()
			@map.fitBounds latLngBounds
				
