# Import
{expect} = require('chai')
joe = require('joe')

# Test
joe.suite 'getpackages', (suite,test) ->
	getter = null

	# Create our contributors instance
	test 'create', ->
		getter = require('../../').create(
			log: console.log
			onlyLatest: true
		)

	# Fetch by names
	suite 'by names', (suite,test) ->
		test 'fetch', (done) ->
			getter.fetchPackagesByNames ['getcontributors', 'getrepos'], (err,entries) ->
				expect(err).to.be.null
				expect(entries).to.be.an('array')
				console.log entries
				expect(entries.length).to.not.equal(0)
				return done()

		test 'combined result', ->
			entries = getter.getEntries()
			expect(entries).to.be.an('array')
			expect(entries.length).to.not.equal(0)

	# Fetch by keyword
	suite 'by keyword', (suite,test) ->
		test 'fetch', (done) ->
			getter.fetchPackagesByKeyword "docpad-plugin", (err,entries) ->
				expect(err).to.be.null
				expect(entries).to.be.an('array')
				expect(entries.length).to.not.equal(0)
				return done()

		test 'combined result', ->
			entries = getter.getEntries()
			expect(entries).to.be.an('array')
			expect(entries.length).to.not.equal(0)
