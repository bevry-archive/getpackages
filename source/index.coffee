# Import
extendr = require('extendr')
typeChecker = require('typechecker')
{TaskGroup} = require('taskgroup')

# Getter
class Getter
	# Entries
	# Object listing of all the entries mapped by their name
	entriesMap: null # {}

	# Config
	config: null  # {}

	# Constructor
	# Create a new contributors instance
	# opts={githubClientId, githubClientSecret} - also forwarded onto feedr
	constructor: (opts={}) ->
		# Prepare
		@config = {}
		@entriesMap = {}

		# Extend configuration
		extendr.extend(@config, {
			log: null
			onlyLatest: true
		}, opts)

		# Feedr
		@feedr = require('feedr').create(@config)

		# Chain
		@

	# Log
	log: (args...) ->
		@config.log?(args...)
		@


	# =================================
	# Add

	# Add an entry to the internal listing and finish preparing it
	# entry = {}
	# return {}
	addEntry: (entry) ->
		# Log
		@log 'debug', 'Adding the package:', entry?.name

		# Check
		return null  unless entry?.name

		# Update references in database
		@entriesMap[entry.name] ?= entry

		# Return
		return @entriesMap[entry.name]


	# =================================
	# Format

	# Get the entries
	# return []
	getEntries: (entries) ->
		# Log
		@log 'debug', 'Get packages'

		# Prepare
		comparator = (a,b) ->
			A = a.name.toLowerCase()
			B = b.name.toLowerCase()
			if A is B
				0
			else if A < B
				-1
			else
				1

		# Allow the user to pass in their own array or object
		if entries? is false
			entries = @entriesMap
		else
			# Remove duplicates from array
			if typeChecker.isArray(entries) is true
				exists = {}
				entries = entries.filter (repo) ->
					return false  unless repo?.name
					exists[repo.name] ?= 0
					++exists[repo.name]
					return exists[repo.name] is 1

		# Convert objects to arrays
		if typeChecker.isPlainObject(entries) is true
			entries = Object.keys(entries).map((key) => entries[key])

		# Prepare the result
		entries = entries.sort(comparator)

		# Return
		return entries


	# =================================
	# Fetch

	# Fetch Package Information from Registry
	# entryName="getpackages"
	# next(err)
	# return @
	requestPackage: (entryName,opts={},next) ->
		# Prepare
		me = @

		# Prepare
		feedOptions =
			url: "http://registry.npmjs.org/#{entryName}"
			parse: 'json'

		# Only latest?
		feedOptions.url += "/latest"  if @config.onlyLatest is true

		# Log
		@log 'debug', 'Requesting package:', entryName, opts, feedOptions

		# Read the repo's package file
		@feedr.readFeed feedOptions, (err,entry) ->
			# Check
			return next(err, {})  if err

			# Add
			addedEntry = me.addEntry(entry)

			# Return
			return next(null, addedEntry)

		# Chain
		@

	# Fetch Packages by Name
	# entryNames=["getpackages"]
	# next(err)
	# return @
	fetchPackagesByNames: (entryNames,next) ->
		# Prepare
		me = @

		# Log
		@log 'debug', 'Fetch packages by name:', entryNames

		# Split it up, github search only supports 79 repos per search it seems...
		# we thought it was due to url length but that doesn't seem to be the case
		# 1732 url with 80 repos fails, 1732 url with 79 repos passes
		entries = []
		tasks = TaskGroup.create(concurrency:0).done (err) ->
			# Check
			return next(err, [])  if err
			result = me.getEntries(entries)
			return next(null, result)

		# Add the tasks
		entryNames.forEach (entryName) ->  tasks.addTask (complete) ->
			me.requestPackage entryName, {}, (err,entry) ->
				return complete(err)  if err
				entries.push(entry)  if entry
				return complete()

		# Run the tasks
		tasks.run()

		# Chain
		@

	# Fetch Packages by Keyword
	# keyword="docpad-plugin"
	# next(err)
	# return @
	fetchPackagesByKeyword: (keyword,next) ->
		# Prepare
		me = @

		# Prepare feed
		feedUrl = "http://registry.npmjs.org/-/_view/byKeyword?startkey=%5B%22#{keyword}%22%5D&endkey=%5B%22#{keyword}%22,%7B%7D%5D&group_level=3"
		feedOptions =
			url: feedUrl
			parse: 'json'

		# Log
		@log 'debug', 'Requesting repos from search:', keyword, feedOptions

		# Read the user's repository feeds
		@feedr.readFeed feedOptions, (err,data) ->
			# Check
			return next(err, [])  if err
			return next(null, [])  unless data?.rows?.length

			# Add
			entryNames = []
			data.rows.forEach (row) ->
				entryName = row.key[1]
				entryNames.push(entryName)

			# Forward
			return me.fetchPackagesByNames(entryNames, next)

		# Chain
		@

# Export
module.exports =
	create: (args...) ->
		return new Getter(args...)
