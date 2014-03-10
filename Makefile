LICENSE_COMMENT="/*! vals 0.1.2 Original author Alan Plum <me@pluma.io>. Released into the Public Domain under the UNLICENSE. @preserve */"

cover: lint
	@./node_modules/.bin/istanbul cover -x "**/spec/**" \
		./node_modules/mocha/bin/_mocha --report lcov spec/ -- -R spec

coveralls:
	@./node_modules/.bin/istanbul cover -x "**/spec/**" \
		./node_modules/mocha/bin/_mocha --report lcovonly spec/ -- -R spec && \
		cat ./coverage/lcov.info | ./node_modules/coveralls/bin/coveralls.js
	@rm -rf ./coverage

test: lint
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
