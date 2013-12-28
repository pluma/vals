/*global describe, it */
var expect = require('expect.js'),
  vals = require('../');

describe('vals.one(obj, str)', function() {
  it('returns undefined if the object is null or undefined', function() {
    expect(vals.one(undefined, 'x')).to.equal(undefined);
    expect(vals.one(null, 'x')).to.equal(undefined);
  });

  it('returns undefined if the property does not exist', function() {
    expect(vals.one(false, 'x')).to.equal(undefined);
    expect(vals.one('', 'x')).to.equal(undefined);
    expect(vals.one(0, 'x')).to.equal(undefined);
    expect(vals.one({}, 'x')).to.equal(undefined);
  });

  it('returns the value if the property exists', function() {
    expect(vals.one({x: 'a'}, 'x')).to.equal('a');
  });
});

describe('vals.one(obj, arr)', function() {
  it('returns undefined if the object is null or undefined', function() {
    expect(vals.one(undefined, ['x'])).to.equal(undefined);
    expect(vals.one(null, ['x'])).to.equal(undefined);
  });

  it('returns undefined if the property does not exist', function() {
    expect(vals.one(false, ['x'])).to.equal(undefined);
    expect(vals.one('', ['x'])).to.equal(undefined);
    expect(vals.one(0, ['x'])).to.equal(undefined);
    expect(vals.one({}, ['x'])).to.equal(undefined);
    expect(vals.one({}, ['x', 'y'])).to.equal(undefined);
    expect(vals.one({x: {}}, ['x', 'y'])).to.equal(undefined);
  });

  it('returns the value if the property exists', function() {
    expect(vals.one({x: 'a'}, ['x'])).to.equal('a');
    expect(vals.one({x: {y: 'a'}}, ['x', 'y'])).to.equal('a');
  });
});

describe('vals(obj, paths…)', function() {
  it('returns an array', function() {
    expect(vals()).to.be.an('array');
    expect(vals({})).to.be.an('array');
    expect(vals({}, '')).to.be.an('array');
  });

  it('is equivalent to calling vals.one for each path', function() {
    var obj = {foo: {bar: 'qux', baz: 'quux'}};
    var path0 = ['foo', 'bar'];
    var path1 = ['foo', 'baz'];
    var path2 = ['foo', 'does not exist'];
    expect(vals(obj, path0)).to.eql([vals.one(obj, path0)]);
    expect(vals(obj, path0, path1, path2)).to.eql([
      vals.one(obj, path0),
      vals.one(obj, path1),
      vals.one(obj, path2)
    ]);
  });
});