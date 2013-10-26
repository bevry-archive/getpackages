
<!-- TITLE/ -->

# Get Packages

<!-- /TITLE -->


<!-- BADGES/ -->

[![Build Status](http://img.shields.io/travis-ci/bevry/getpackages.png?branch=master)](http://travis-ci.org/bevry/getpackages "Check this project's build status on TravisCI")
[![NPM version](https://badge.fury.io/js/getpackages.png)](https://npmjs.org/package/getpackages "View this project on NPM")
[![Gittip donate button](http://img.shields.io/gittip/bevry.png)](https://www.gittip.com/bevry/ "Donate weekly to this project using Gittip")
[![Flattr donate button](https://raw.github.com/balupton/flattr-buttons/master/badge-89x18.gif)](http://flattr.com/thing/344188/balupton-on-Flattr "Donate monthly to this project using Flattr")
[![PayPayl donate button](https://www.paypalobjects.com/en_AU/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QB8GQPZAH84N6 "Donate once-off to this project using Paypal")

<!-- /BADGES -->


<!-- DESCRIPTION/ -->

Fetch the information for packages inside the npm registry

<!-- /DESCRIPTION -->


<!-- INSTALL/ -->

## Install

### [Node](http://nodejs.org/), [Browserify](http://browserify.org/)
- Use: `require('getpackages')`
- Install: `npm install --save getpackages`

### [Ender](http://ender.jit.su/)
- Use: `require('getpackages')`
- Install: `ender add getpackages`

<!-- /INSTALL -->


## Usage

``` javascript
// Create our instance
var getter = require('getpackages').create({
	onlyLatest: true,           // optional (defaults to `true`), accepts a boolean, `true` will fetch information only for the latest version, `false` wil fetch information for all versions
	log: console.log           // optional (defaults to `null`), accepts a function that accepts the arguments: level, message... 
});

// Fetch the data on these github repositories
getter.fetchPackagesByNames(['bevry/getpackages'], function(err, entries){
	console.log(err, entries);

	// Fetch all the repo data on these github users/organisations
	getter.fetchPackagesByKeyword('docpad-plugin', function(err, entries){
		console.log(err, entries);

		// Get the combined listing
		console.log(getter.getEntries());
	});
});
```

- When `onlyLatest` is `true`, entry data is retrieved from: http://registry.npmjs.org/#{packageName}/latest
- When `onlyLatest` is `false`, entry data is retrieved from: http://registry.npmjs.org/#{packageName}


<!-- CONTRIBUTE/ -->

## Contribute

[Discover how you can contribute by heading on over to the `Contributing.md` file.](https://github.com/bevry/getpackages/blob/master/Contributing.md#files)

<!-- /CONTRIBUTE -->


<!-- HISTORY/ -->

## History
[Discover the change history by heading on over to the `History.md` file.](https://github.com/bevry/getpackages/blob/master/History.md#files)

<!-- /HISTORY -->


<!-- BACKERS/ -->

## Backers

### Maintainers

These amazing people are maintaining this project:

- Benjamin Lupton <b@lupton.cc> (https://github.com/balupton)

### Sponsors

No sponsors yet! Will you be the first?

[![Gittip donate button](http://img.shields.io/gittip/bevry.png)](https://www.gittip.com/bevry/ "Donate weekly to this project using Gittip")
[![Flattr donate button](https://raw.github.com/balupton/flattr-buttons/master/badge-89x18.gif)](http://flattr.com/thing/344188/balupton-on-Flattr "Donate monthly to this project using Flattr")
[![PayPayl donate button](https://www.paypalobjects.com/en_AU/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QB8GQPZAH84N6 "Donate once-off to this project using Paypal")

### Contributors

No contributors yet! Will you be the first?
[Discover how you can contribute by heading on over to the `Contributing.md` file.](https://github.com/bevry/getpackages/blob/master/Contributing.md#files)

<!-- /BACKERS -->


<!-- LICENSE/ -->

## License

Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT license](http://creativecommons.org/licenses/MIT/)

Copyright &copy; 2013+ Bevry Pty Ltd <us@bevry.me> (http://bevry.me)

<!-- /LICENSE -->


