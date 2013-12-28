LICENSE_COMMENT="/*! vals 0.1.0 Copyright (c) 2013 Alan Plum. MIT licensed. @preserve */"

test: lint dist
	@./node_modules/.bin/mocha \
		--growl \
		--reporter spec \
		spec/*.spec.js

clean:
	@rm -f 	dist/*

dist/vals.js:
	@echo $(LICENSE_COMMENT) > dist/vals.js
	@cat src/vals.js >> dist/vals.js

dist/vals.globals.js:
	@echo $(LICENSE_COMMENT) > dist/vals.globals.js
	@echo "(function(root){\
	var require=function(key){return root[key];},\
	module={};" >> dist/vals.globals.js
	@cat src/vals.js >> dist/vals.globals.js
	@echo "root.vals = module.exports;\
	}(this));" >> dist/vals.globals.js

dist/vals.amd.js:
	@echo $(LICENSE_COMMENT) > dist/vals.amd.js
	@echo "define(function(require, exports, module) {" >> dist/vals.amd.js
	@cat src/vals.js >> dist/vals.amd.js
	@echo "return module.exports;});" >> dist/vals.amd.js

dist/vals.min.js: dist/vals.js
	@./node_modules/.bin/uglifyjs dist/vals.js --comments -m > dist/vals.min.js

dist/vals.globals.min.js: dist/vals.globals.js
	@./node_modules/.bin/uglifyjs dist/vals.globals.js --comments -m > dist/vals.globals.min.js

dist/vals.amd.min.js: dist/vals.amd.js
	@./node_modules/.bin/uglifyjs dist/vals.amd.js --comments > dist/vals.amd.min.js

dist: clean dist/vals.min.js dist/vals.globals.min.js dist/vals.amd.min.js

lint:
	@./node_modules/.bin/jshint src/vals.js spec
