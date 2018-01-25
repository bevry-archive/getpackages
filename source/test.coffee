# Import
joe = require('joe')
{equal, errorEqual} = require('assert-helpers')

# Test
joe.suite 'getpackages', (suite,test) ->
	getter = null

	# Create our contributors instance
	test 'create', ->
		getter = require('../').create(
			log: console.log
			onlyLatest: true
		)

	# Fetch by names
	suite 'by names', (suite,test) ->
		test 'fetch', (done) ->
			getter.fetchPackagesByNames ['getcontributors', 'getrepos'], (err,entries) ->
				errorEqual(err, null)
				equal(Array.isArray(entries), true)
				console.log(entries)
				equal(entries.length > 0, true)
				return done()

		test 'combined result', ->
			entries = getter.getEntries()
			equal(Array.isArray(entries), true)
			equal(entries.length > 0, true)

	# Fetch by keyword
	suite 'by keyword', (suite,test) ->
		test 'fetch', (done) ->
			getter.fetchPackagesByKeyword "docpad-plugin", (err,entries) ->
				errorEqual(err, null)
				equal(Array.isArray(entries), true)
				equal(entries.length > 0, true)
				return done()

		test 'combined result', ->
			entries = getter.getEntries()
			equal(Array.isArray(entries), true)
			equal(entries.length > 0, true)
