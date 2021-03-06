# Synopsis

**vals** is a utility library for extracting property values from an object with support for safe nested property lookup.

[![stability 3 - stable](http://b.repl.ca/v1/stability-3_--_stable-yellowgreen.png)
](http://nodejs.org/api/documentation.html#documentation_stability_index) [![license - Unlicense](http://b.repl.ca/v1/license-Unlicense-lightgrey.png)](http://unlicense.org/) [![Flattr this](https://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=pluma&url=https://github.com/pluma/vals)

[![browser support](https://ci.testling.com/pluma/vals.png)](https://ci.testling.com/pluma/vals)

[![Build Status](https://travis-ci.org/pluma/vals.png?branch=master)](https://travis-ci.org/pluma/vals) [![Coverage Status](https://coveralls.io/repos/pluma/vals/badge.png?branch=master)](https://coveralls.io/r/pluma/vals?branch=master) [![Dependencies](https://david-dm.org/pluma/vals.png?theme=shields.io)](https://david-dm.org/pluma/vals)

[![NPM status](https://nodei.co/npm/vals.png?compact=true)](https://npmjs.org/package/vals)

# Install

## Node.js

### With NPM

```sh
npm install vals
```

### From source

```sh
git clone https://github.com/pluma/vals.git
cd vals
npm install
make
```

## Browser

### With component

```sh
component install pluma/vals
```

[Learn more about component](https://github.com/component/component).

### With bower

```sh
bower install vals
```

[Learn more about bower](https://github.com/twitter/bower).

### With a CommonJS module loader

Download the [latest minified CommonJS release](https://raw.github.com/pluma/vals/master/dist/vals.min.js) and add it to your project.

[Learn more about CommonJS modules](http://wiki.commonjs.org/wiki/Modules/1.1).

### With an AMD module loader

Download the [latest minified AMD release](https://raw.github.com/pluma/vals/master/dist/vals.amd.min.js) and add it to your project.

[Learn more about AMD modules](http://requirejs.org/docs/whyamd.html).

### As a standalone library

Download the [latest minified standalone release](https://raw.github.com/pluma/vals/master/dist/vals.globals.min.js) and add it to your project.

```html
<script src="/your/js/path/vals.globals.min.js"></script>
```

This makes the `vals` module available in the global namespace.

# Basic usage example

```javascript
var vals = require('vals');

var obj1 = {a: 'one', b: 'two', c: 'three'};
vals(obj1, 'a', 'b'); // ['one', 'two']

var obj2 = {foo: {bar: {qux: 'one', baz: 'two'}}};
vals(obj2, ['foo', 'bar', 'qux']); // ['one']
vals.one(obj2, ['foo', 'bar', 'qux']); // 'one'
vals(obj2, ['fail', 'bar', 'qux']); // [undefined]

var obj3 = undefined;
vals(obj3, 'foo', ['bar', 'qux']); // [undefined, undefined]
vals.one(obj3, 'foo'); // undefined
```

# API

## vals(obj, paths…):Array

Extracts the property values at each given property path as an array.

## vals.one(obj, path):*

Attempts to extract the property value at the given property path.

If `path` is an array, it will attempt to resolve the property path recursively.

If the path can not be resolved fully, the return value will be `undefined`.

# Unlicense

This is free and unencumbered public domain software. For more information, see http://unlicense.org/ or the accompanying [UNLICENSE](https://github.com/pluma/sic/blob/master/UNLICENSE) file.