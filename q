[1mdiff --git a/dist/electron/main.js b/dist/electron/main.js[m
[1mindex 465797d..927022a 100644[m
[1m--- a/dist/electron/main.js[m
[1m+++ b/dist/electron/main.js[m
[36m@@ -1,7259 +1 @@[m
[31m-module.exports =[m
[31m-/******/ (function(modules) { // webpackBootstrap[m
[31m-/******/ 	// The module cache[m
[31m-/******/ 	var installedModules = {};[m
[31m-/******/[m
[31m-/******/ 	// The require function[m
[31m-/******/ 	function __webpack_require__(moduleId) {[m
[31m-/******/[m
[31m-/******/ 		// Check if module is in cache[m
[31m-/******/ 		if(installedModules[moduleId]) {[m
[31m-/******/ 			return installedModules[moduleId].exports;[m
[31m-/******/ 		}[m
[31m-/******/ 		// Create a new module (and put it into the cache)[m
[31m-/******/ 		var module = installedModules[moduleId] = {[m
[31m-/******/ 			i: moduleId,[m
[31m-/******/ 			l: false,[m
[31m-/******/ 			exports: {}[m
[31m-/******/ 		};[m
[31m-/******/[m
[31m-/******/ 		// Execute the module function[m
[31m-/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);[m
[31m-/******/[m
[31m-/******/ 		// Flag the module as loaded[m
[31m-/******/ 		module.l = true;[m
[31m-/******/[m
[31m-/******/ 		// Return the exports of the module[m
[31m-/******/ 		return module.exports;[m
[31m-/******/ 	}[m
[31m-/******/[m
[31m-/******/[m
[31m-/******/ 	// expose the modules object (__webpack_modules__)[m
[31m-/******/ 	__webpack_require__.m = modules;[m
[31m-/******/[m
[31m-/******/ 	// expose the module cache[m
[31m-/******/ 	__webpack_require__.c = installedModules;[m
[31m-/******/[m
[31m-/******/ 	// define getter function for harmony exports[m
[31m-/******/ 	__webpack_require__.d = function(exports, name, getter) {[m
[31m-/******/ 		if(!__webpack_require__.o(exports, name)) {[m
[31m-/******/ 			Object.defineProperty(exports, name, {[m
[31m-/******/ 				configurable: false,[m
[31m-/******/ 				enumerable: true,[m
[31m-/******/ 				get: getter[m
[31m-/******/ 			});[m
[31m-/******/ 		}[m
[31m-/******/ 	};[m
[31m-/******/[m
[31m-/******/ 	// getDefaultExport function for compatibility with non-harmony modules[m
[31m-/******/ 	__webpack_require__.n = function(module) {[m
[31m-/******/ 		var getter = module && module.__esModule ?[m
[31m-/******/ 			function getDefault() { return module['default']; } :[m
[31m-/******/ 			function getModuleExports() { return module; };[m
[31m-/******/ 		__webpack_require__.d(getter, 'a', getter);[m
[31m-/******/ 		return getter;[m
[31m-/******/ 	};[m
[31m-/******/[m
[31m-/******/ 	// Object.prototype.hasOwnProperty.call[m
[31m-/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };[m
[31m-/******/[m
[31m-/******/ 	// __webpack_public_path__[m
[31m-/******/ 	__webpack_require__.p = "";[m
[31m-/******/[m
[31m-/******/ 	// Load entry module and return exports[m
[31m-/******/ 	return __webpack_require__(__webpack_require__.s = 16);[m
[31m-/******/ })[m
[31m-/************************************************************************/[m
[31m-/******/ ([[m
[31m-/* 0 */[m
[31m-/***/ (function(module, exports) {[m
[31m-[m
[31m-module.exports = require("path");[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 1 */[m
[31m-/***/ (function(module, exports) {[m
[31m-[m
[31m-module.exports = require("fs");[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 2 */[m
[31m-/***/ (function(module, exports) {[m
[31m-[m
[31m-module.exports = require("electron");[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 3 */[m
[31m-/***/ (function(module, exports) {[m
[31m-[m
[31m-module.exports = require("util");[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 4 */[m
[31m-/***/ (function(module, exports) {[m
[31m-[m
[31m-module.exports = require("assert");[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 5 */[m
[31m-/***/ (function(module, exports, __webpack_require__) {[m
[31m-[m
[31m-module.exports = minimatch[m
[31m-minimatch.Minimatch = Minimatch[m
[31m-[m
[31m-var path = { sep: '/' }[m
[31m-try {[m
[31m-  path = __webpack_require__(0)[m
[31m-} catch (er) {}[m
[31m-[m
[31m-var GLOBSTAR = minimatch.GLOBSTAR = Minimatch.GLOBSTAR = {}[m
[31m-var expand = __webpack_require__(35)[m
[31m-[m
[31m-var plTypes = {[m
[31m-  '!': { open: '(?:(?!(?:', close: '))[^/]*?)'},[m
[31m-  '?': { open: '(?:', close: ')?' },[m
[31m-  '+': { open: '(?:', close: ')+' },[m
[31m-  '*': { open: '(?:', close: ')*' },[m
[31m-  '@': { open: '(?:', close: ')' }[m
[31m-}[m
[31m-[m
[31m-// any single thing other than /[m
[31m-// don't need to escape / when using new RegExp()[m
[31m-var qmark = '[^/]'[m
[31m-[m
[31m-// * => any number of characters[m
[31m-var star = qmark + '*?'[m
[31m-[m
[31m-// ** when dots are allowed.  Anything goes, except .. and .[m
[31m-// not (^ or / followed by one or two dots followed by $ or /),[m
[31m-// followed by anything, any number of times.[m
[31m-var twoStarDot = '(?:(?!(?:\\\/|^)(?:\\.{1,2})($|\\\/)).)*?'[m
[31m-[m
[31m-// not a ^ or / followed by a dot,[m
[31m-// followed by anything, any number of times.[m
[31m-var twoStarNoDot = '(?:(?!(?:\\\/|^)\\.).)*?'[m
[31m-[m
[31m-// characters that need to be escaped in RegExp.[m
[31m-var reSpecials = charSet('().*{}+?[]^$\\!')[m
[31m-[m
[31m-// "abc" -> { a:true, b:true, c:true }[m
[31m-function charSet (s) {[m
[31m-  return s.split('').reduce(function (set, c) {[m
[31m-    set[c] = true[m
[31m-    return set[m
[31m-  }, {})[m
[31m-}[m
[31m-[m
[31m-// normalizes slashes.[m
[31m-var slashSplit = /\/+/[m
[31m-[m
[31m-minimatch.filter = filter[m
[31m-function filter (pattern, options) {[m
[31m-  options = options || {}[m
[31m-  return function (p, i, list) {[m
[31m-    return minimatch(p, pattern, options)[m
[31m-  }[m
[31m-}[m
[31m-[m
[31m-function ext (a, b) {[m
[31m-  a = a || {}[m
[31m-  b = b || {}[m
[31m-  var t = {}[m
[31m-  Object.keys(b).forEach(function (k) {[m
[31m-    t[k] = b[k][m
[31m-  })[m
[31m-  Object.keys(a).forEach(function (k) {[m
[31m-    t[k] = a[k][m
[31m-  })[m
[31m-  return t[m
[31m-}[m
[31m-[m
[31m-minimatch.defaults = function (def) {[m
[31m-  if (!def || !Object.keys(def).length) return minimatch[m
[31m-[m
[31m-  var orig = minimatch[m
[31m-[m
[31m-  var m = function minimatch (p, pattern, options) {[m
[31m-    return orig.minimatch(p, pattern, ext(def, options))[m
[31m-  }[m
[31m-[m
[31m-  m.Minimatch = function Minimatch (pattern, options) {[m
[31m-    return new orig.Minimatch(pattern, ext(def, options))[m
[31m-  }[m
[31m-[m
[31m-  return m[m
[31m-}[m
[31m-[m
[31m-Minimatch.defaults = function (def) {[m
[31m-  if (!def || !Object.keys(def).length) return Minimatch[m
[31m-  return minimatch.defaults(def).Minimatch[m
[31m-}[m
[31m-[m
[31m-function minimatch (p, pattern, options) {[m
[31m-  if (typeof pattern !== 'string') {[m
[31m-    throw new TypeError('glob pattern string required')[m
[31m-  }[m
[31m-[m
[31m-  if (!options) options = {}[m
[31m-[m
[31m-  // shortcut: comments match nothing.[m
[31m-  if (!options.nocomment && pattern.charAt(0) === '#') {[m
[31m-    return false[m
[31m-  }[m
[31m-[m
[31m-  // "" only matches ""[m
[31m-  if (pattern.trim() === '') return p === ''[m
[31m-[m
[31m-  return new Minimatch(pattern, options).match(p)[m
[31m-}[m
[31m-[m
[31m-function Minimatch (pattern, options) {[m
[31m-  if (!(this instanceof Minimatch)) {[m
[31m-    return new Minimatch(pattern, options)[m
[31m-  }[m
[31m-[m
[31m-  if (typeof pattern !== 'string') {[m
[31m-    throw new TypeError('glob pattern string required')[m
[31m-  }[m
[31m-[m
[31m-  if (!options) options = {}[m
[31m-  pattern = pattern.trim()[m
[31m-[m
[31m-  // windows support: need to use /, not \[m
[31m-  if (path.sep !== '/') {[m
[31m-    pattern = pattern.split(path.sep).join('/')[m
[31m-  }[m
[31m-[m
[31m-  this.options = options[m
[31m-  this.set = [][m
[31m-  this.pattern = pattern[m
[31m-  this.regexp = null[m
[31m-  this.negate = false[m
[31m-  this.comment = false[m
[31m-  this.empty = false[m
[31m-[m
[31m-  // make the set of regexps etc.[m
[31m-  this.make()[m
[31m-}[m
[31m-[m
[31m-Minimatch.prototype.debug = function () {}[m
[31m-[m
[31m-Minimatch.prototype.make = make[m
[31m-function make () {[m
[31m-  // don't do it more than once.[m
[31m-  if (this._made) return[m
[31m-[m
[31m-  var pattern = this.pattern[m
[31m-  var options = this.options[m
[31m-[m
[31m-  // empty patterns and comments match nothing.[m
[31m-  if (!options.nocomment && pattern.charAt(0) === '#') {[m
[31m-    this.comment = true[m
[31m-    return[m
[31m-  }[m
[31m-  if (!pattern) {[m
[31m-    this.empty = true[m
[31m-    return[m
[31m-  }[m
[31m-[m
[31m-  // step 1: figure out negation, etc.[m
[31m-  this.parseNegate()[m
[31m-[m
[31m-  // step 2: expand braces[m
[31m-  var set = this.globSet = this.braceExpand()[m
[31m-[m
[31m-  if (options.debug) this.debug = console.error[m
[31m-[m
[31m-  this.debug(this.pattern, set)[m
[31m-[m
[31m-  // step 3: now we have a set, so turn each one into a series of path-portion[m
[31m-  // matching patterns.[m
[31m-  // These will be regexps, except in the case of "**", which is[m
[31m-  // set to the GLOBSTAR object for globstar behavior,[m
[31m-  // and will not contain any / characters[m
[31m-  set = this.globParts = set.map(function (s) {[m
[31m-    return s.split(slashSplit)[m
[31m-  })[m
[31m-[m
[31m-  this.debug(this.pattern, set)[m
[31m-[m
[31m-  // glob --> regexps[m
[31m-  set = set.map(function (s, si, set) {[m
[31m-    return s.map(this.parse, this)[m
[31m-  }, this)[m
[31m-[m
[31m-  this.debug(this.pattern, set)[m
[31m-[m
[31m-  // filter out everything that didn't compile properly.[m
[31m-  set = set.filter(function (s) {[m
[31m-    return s.indexOf(false) === -1[m
[31m-  })[m
[31m-[m
[31m-  this.debug(this.pattern, set)[m
[31m-[m
[31m-  this.set = set[m
[31m-}[m
[31m-[m
[31m-Minimatch.prototype.parseNegate = parseNegate[m
[31m-function parseNegate () {[m
[31m-  var pattern = this.pattern[m
[31m-  var negate = false[m
[31m-  var options = this.options[m
[31m-  var negateOffset = 0[m
[31m-[m
[31m-  if (options.nonegate) return[m
[31m-[m
[31m-  for (var i = 0, l = pattern.length[m
[31m-    ; i < l && pattern.charAt(i) === '!'[m
[31m-    ; i++) {[m
[31m-    negate = !negate[m
[31m-    negateOffset++[m
[31m-  }[m
[31m-[m
[31m-  if (negateOffset) this.pattern = pattern.substr(negateOffset)[m
[31m-  this.negate = negate[m
[31m-}[m
[31m-[m
[31m-// Brace expansion:[m
[31m-// a{b,c}d -> abd acd[m
[31m-// a{b,}c -> abc ac[m
[31m-// a{0..3}d -> a0d a1d a2d a3d[m
[31m-// a{b,c{d,e}f}g -> abg acdfg acefg[m
[31m-// a{b,c}d{e,f}g -> abdeg acdeg abdeg abdfg[m
[31m-//[m
[31m-// Invalid sets are not expanded.[m
[31m-// a{2..}b -> a{2..}b[m
[31m-// a{b}c -> a{b}c[m
[31m-minimatch.braceExpand = function (pattern, options) {[m
[31m-  return braceExpand(pattern, options)[m
[31m-}[m
[31m-[m
[31m-Minimatch.prototype.braceExpand = braceExpand[m
[31m-[m
[31m-function braceExpand (pattern, options) {[m
[31m-  if (!options) {[m
[31m-    if (this instanceof Minimatch) {[m
[31m-      options = this.options[m
[31m-    } else {[m
[31m-      options = {}[m
[31m-    }[m
[31m-  }[m
[31m-[m
[31m-  pattern = typeof pattern === 'undefined'[m
[31m-    ? this.pattern : pattern[m
[31m-[m
[31m-  if (typeof pattern === 'undefined') {[m
[31m-    throw new TypeError('undefined pattern')[m
[31m-  }[m
[31m-[m
[31m-  if (options.nobrace ||[m
[31m-    !pattern.match(/\{.*\}/)) {[m
[31m-    // shortcut. no need to expand.[m
[31m-    return [pattern][m
[31m-  }[m
[31m-[m
[31m-  return expand(pattern)[m
[31m-}[m
[31m-[m
[31m-// parse a component of the expanded set.[m
[31m-// At this point, no pattern may contain "/" in it[m
[31m-// so we're going to return a 2d array, where each entry is the full[m
[31m-// pattern, split on '/', and then turned into a regular expression.[m
[31m-// A regexp is made at the end which joins each array with an[m
[31m-// escaped /, and another full one which joins each regexp with |.[m
[31m-//[m
[31m-// Following the lead of Bash 4.1, note that "**" only has special meaning[m
[31m-// when it is the *only* thing in a path portion.  Otherwise, any series[m
[31m-// of * is equivalent to a single *.  Globstar behavior is enabled by[m
[31m-// default, and can be disabled by setting options.noglobstar.[m
[31m-Minimatch.prototype.parse = parse[m
[31m-var SUBPARSE = {}[m
[31m-function parse (pattern, isSub) {[m
[31m-  if (pattern.length > 1024 * 64) {[m
[31m-    throw new TypeError('pattern is too long')[m
[31m-  }[m
[31m-[m
[31m-  var options = this.options[m
[31m-[m
[31m-  // shortcuts[m
[31m-  if (!options.noglobstar && pattern === '**') return GLOBSTAR[m
[31m-  if (pattern === '') return ''[m
[31m-[m
[31m-  var re = ''[m
[31m-  var hasMagic = !!options.nocase[m
[31m-  var escaping = false[m
[31m-  // ? => one single character[m
[31m-  var patternListStack = [][m
[31m-  var negativeLists = [][m
[31m-  var stateChar[m
[31m-  var inClass = false[m
[31m-  var reClassStart = -1[m
[31m-  var classStart = -1[m
[31m-  // . and .. never match anything that doesn't start with .,[m
[31m-  // even when options.dot is set.[m
[31m-  var patternStart = pattern.charAt(0) === '.' ? '' // anything[m
[31m-  // not (start or / followed by . or .. followed by / or end)[m
[31m-  : options.dot ? '(?!(?:^|\\\/)\\.{1,2}(?:$|\\\/))'[m
[31m-  : '(?!\\.)'[m
[31m-  var self = this[m
[31m-[m
[31m-  function clearStateChar () {[m
[31m-    if (stateChar) {[m
[31m-      // we had some state-tracking character[m
[31m-      // that wasn't consumed by this pass.[m
[31m-      switch (stateChar) {[m
[31m-        case '*':[m
[31m-          re += star[m
[31m-          hasMagic = true[m
[31m-        break[m
[31m-        case '?':[m
[31m-          re += qmark[m
[31m-          hasMagic = true[m
[31m-        break[m
[31m-        default:[m
[31m-          re += '\\' + stateChar[m
[31m-        break[m
[31m-      }[m
[31m-      self.debug('clearStateChar %j %j', stateChar, re)[m
[31m-      stateChar = false[m
[31m-    }[m
[31m-  }[m
[31m-[m
[31m-  for (var i = 0, len = pattern.length, c[m
[31m-    ; (i < len) && (c = pattern.charAt(i))[m
[31m-    ; i++) {[m
[31m-    this.debug('%s\t%s %s %j', pattern, i, re, c)[m
[31m-[m
[31m-    // skip over any that are escaped.[m
[31m-    if (escaping && reSpecials[c]) {[m
[31m-      re += '\\' + c[m
[31m-      escaping = false[m
[31m-      continue[m
[31m-    }[m
[31m-[m
[31m-    switch (c) {[m
[31m-      case '/':[m
[31m-        // completely not allowed, even escaped.[m
[31m-        // Should already be path-split by now.[m
[31m-        return false[m
[31m-[m
[31m-      case '\\':[m
[31m-        clearStateChar()[m
[31m-        escaping = true[m
[31m-      continue[m
[31m-[m
[31m-      // the various stateChar values[m
[31m-      // for the "extglob" stuff.[m
[31m-      case '?':[m
[31m-      case '*':[m
[31m-      case '+':[m
[31m-      case '@':[m
[31m-      case '!':[m
[31m-        this.debug('%s\t%s %s %j <-- stateChar', pattern, i, re, c)[m
[31m-[m
[31m-        // all of those are literals inside a class, except that[m
[31m-        // the glob [!a] means [^a] in regexp[m
[31m-        if (inClass) {[m
[31m-          this.debug('  in class')[m
[31m-          if (c === '!' && i === classStart + 1) c = '^'[m
[31m-          re += c[m
[31m-          continue[m
[31m-        }[m
[31m-[m
[31m-        // if we already have a stateChar, then it means[m
[31m-        // that there was something like ** or +? in there.[m
[31m-        // Handle the stateChar, then proceed with this one.[m
[31m-        self.debug('call clearStateChar %j', stateChar)[m
[31m-        clearStateChar()[m
[31m-        stateChar = c[m
[31m-        // if extglob is disabled, then +(asdf|foo) isn't a thing.[m
[31m-        // just clear the statechar *now*, rather than even diving into[m
[31m-        // the patternList stuff.[m
[31m-        if (options.noext) clearStateChar()[m
[31m-      continue[m
[31m-[m
[31m-      case '(':[m
[31m-        if (inClass) {[m
[31m-          re += '('[m
[31m-          continue[m
[31m-        }[m
[31m-[m
[31m-        if (!stateChar) {[m
[31m-          re += '\\('[m
[31m-          continue[m
[31m-        }[m
[31m-[m
[31m-        patternListStack.push({[m
[31m-          type: stateChar,[m
[31m-          start: i - 1,[m
[31m-          reStart: re.length,[m
[31m-          open: plTypes[stateChar].open,[m
[31m-          close: plTypes[stateChar].close[m
[31m-        })[m
[31m-        // negation is (?:(?!js)[^/]*)[m
[31m-        re += stateChar === '!' ? '(?:(?!(?:' : '(?:'[m
[31m-        this.debug('plType %j %j', stateChar, re)[m
[31m-        stateChar = false[m
[31m-      continue[m
[31m-[m
[31m-      case ')':[m
[31m-        if (inClass || !patternListStack.length) {[m
[31m-          re += '\\)'[m
[31m-          continue[m
[31m-        }[m
[31m-[m
[31m-        clearStateChar()[m
[31m-        hasMagic = true[m
[31m-        var pl = patternListStack.pop()[m
[31m-        // negation is (?:(?!js)[^/]*)[m
[31m-        // The others are (?:<pattern>)<type>[m
[31m-        re += pl.close[m
[31m-        if (pl.type === '!') {[m
[31m-          negativeLists.push(pl)[m
[31m-        }[m
[31m-        pl.reEnd = re.length[m
[31m-      continue[m
[31m-[m
[31m-      case '|':[m
[31m-        if (inClass || !patternListStack.length || escaping) {[m
[31m-          re += '\\|'[m
[31m-          escaping = false[m
[31m-          continue[m
[31m-        }[m
[31m-[m
[31m-        clearStateChar()[m
[31m-        re += '|'[m
[31m-      continue[m
[31m-[m
[31m-      // these are mostly the same in regexp and glob[m
[31m-      case '[':[m
[31m-        // swallow any state-tracking char before the [[m
[31m-        clearStateChar()[m
[31m-[m
[31m-        if (inClass) {[m
[31m-          re += '\\' + c[m
[31m-          continue[m
[31m-        }[m
[31m-[m
[31m-        inClass = true[m
[31m-        classStart = i[m
[31m-        reClassStart = re.length[m
[31m-        re += c[m
[31m-      continue[m
[31m-[m
[31m-      case ']':[m
[31m-        //  a right bracket shall lose its special[m
[31m-        //  meaning and represent itself in[m
[31m-        //  a bracket expression if it occurs[m
[31m-        //  first in the list.  -- POSIX.2 2.8.3.2[m
[31m-        if (i === classStart + 1 || !inClass) {[m
[31m-          re += '\\' + c[m
[31m-          escaping = false[m
[31m-          continue[m
[31m-        }[m
[31m-[m
[31m-        // handle the case where we left a class open.[m
[31m-        // "[z-a]" is valid, equivalent to "\[z-a\]"[m
[31m-        if (inClass) {[m
[31m-          // split where the last [ was, make sure we don't have[m
[31m-          // an invalid re. if so, re-walk the contents of the[m
[31m-          // would-be class to re-translate any characters that[m
[31m-          // were passed through as-is[m
[31m-          // TODO: It would probably be faster to determine this[m
[31m-          // without a try/catch and a new RegExp, but it's tricky[m
[31m-          // to do safely.  For now, this is safe and works.[m
[31m-          var cs = pattern.substring(classStart + 1, i)[m
[31m-          try {[m
[31m-            RegExp('[' + cs + ']')[m
[31m-          } catch (er) {[m
[31m-            // not a valid class![m
[31m-            var sp = this.parse(cs, SUBPARSE)[m
[31m-            re = re.substr(0, reClassStart) + '\\[' + sp[0] + '\\]'[m
[31m-            hasMagic = hasMagic || sp[1][m
[31m-            inClass = false[m
[31m-            continue[m
[31m-          }[m
[31m-        }[m
[31m-[m
[31m-        // finish up the class.[m
[31m-        hasMagic = true[m
[31m-        inClass = false[m
[31m-        re += c[m
[31m-      continue[m
[31m-[m
[31m-      default:[m
[31m-        // swallow any state char that wasn't consumed[m
[31m-        clearStateChar()[m
[31m-[m
[31m-        if (escaping) {[m
[31m-          // no need[m
[31m-          escaping = false[m
[31m-        } else if (reSpecials[c][m
[31m-          && !(c === '^' && inClass)) {[m
[31m-          re += '\\'[m
[31m-        }[m
[31m-[m
[31m-        re += c[m
[31m-[m
[31m-    } // switch[m
[31m-  } // for[m
[31m-[m
[31m-  // handle the case where we left a class open.[m
[31m-  // "[abc" is valid, equivalent to "\[abc"[m
[31m-  if (inClass) {[m
[31m-    // split where the last [ was, and escape it[m
[31m-    // this is a huge pita.  We now have to re-walk[m
[31m-    // the contents of the would-be class to re-translate[m
[31m-    // any characters that were passed through as-is[m
[31m-    cs = pattern.substr(classStart + 1)[m
[31m-    sp = this.parse(cs, SUBPARSE)[m
[31m-    re = re.substr(0, reClassStart) + '\\[' + sp[0][m
[31m-    hasMagic = hasMagic || sp[1][m
[31m-  }[m
[31m-[m
[31m-  // handle the case where we had a +( thing at the *end*[m
[31m-  // of the pattern.[m
[31m-  // each pattern list stack adds 3 chars, and we need to go through[m
[31m-  // and escape any | chars that were passed through as-is for the regexp.[m
[31m-  // Go through and escape them, taking care not to double-escape any[m
[31m-  // | chars that were already escaped.[m
[31m-  for (pl = patternListStack.pop(); pl; pl = patternListStack.pop()) {[m
[31m-    var tail = re.slice(pl.reStart + pl.open.length)[m
[31m-    this.debug('setting tail', re, pl)[m
[31m-    // maybe some even number of \, then maybe 1 \, followed by a |[m
[31m-    tail = tail.replace(/((?:\\{2}){0,64})(\\?)\|/g, function (_, $1, $2) {[m
[31m-      if (!$2) {[m
[31m-        // the | isn't already escaped, so escape it.[m
[31m-        $2 = '\\'[m
[31m-      }[m
[31m-[m
[31m-      // need to escape all those slashes *again*, without escaping the[m
[31m-      // one that we need for escaping the | character.  As it works out,[m
[31m-      // escaping an even number of slashes can be done by simply repeating[m
[31m-      // it exactly after itself.  That's why this trick works.[m
[31m-      //[m
[31m-      // I am sorry that you have to see this.[m
[31m-      return $1 + $1 + $2 + '|'[m
[31m-    })[m
[31m-[m
[31m-    this.debug('tail=%j\n   %s', tail, tail, pl, re)[m
[31m-    var t = pl.type === '*' ? star[m
[31m-      : pl.type === '?' ? qmark[m
[31m-      : '\\' + pl.type[m
[31m-[m
[31m-    hasMagic = true[m
[31m-    re = re.slice(0, pl.reStart) + t + '\\(' + tail[m
[31m-  }[m
[31m-[m
[31m-  // handle trailing things that only matter at the very end.[m
[31m-  clearStateChar()[m
[31m-  if (escaping) {[m
[31m-    // trailing \\[m
[31m-    re += '\\\\'[m
[31m-  }[m
[31m-[m
[31m-  // only need to apply the nodot start if the re starts with[m
[31m-  // something that could conceivably capture a dot[m
[31m-  var addPatternStart = false[m
[31m-  switch (re.charAt(0)) {[m
[31m-    case '.':[m
[31m-    case '[':[m
[31m-    case '(': addPatternStart = true[m
[31m-  }[m
[31m-[m
[31m-  // Hack to work around lack of negative lookbehind in JS[m
[31m-  // A pattern like: *.!(x).!(y|z) needs to ensure that a name[m
[31m-  // like 'a.xyz.yz' doesn't match.  So, the first negative[m
[31m-  // lookahead, has to look ALL the way ahead, to the end of[m
[31m-  // the pattern.[m
[31m-  for (var n = negativeLists.length - 1; n > -1; n--) {[m
[31m-    var nl = negativeLists[n][m
[31m-[m
[31m-    var nlBefore = re.slice(0, nl.reStart)[m
[31m-    var nlFirst = re.slice(nl.reStart, nl.reEnd - 8)[m
[31m-    var nlLast = re.slice(nl.reEnd - 8, nl.reEnd)[m
[31m-    var nlAfter = re.slice(nl.reEnd)[m
[31m-[m
[31m-    nlLast += nlAfter[m
[31m-[m
[31m-    // Handle nested stuff like *(*.js|!(*.json)), where open parens[m
[31m-    // mean that we should *not* include the ) in the bit that is considered[m
[31m-    // "after" the negated section.[m
[31m-    var openParensBefore = nlBefore.split('(').length - 1[m
[31m-    var cleanAfter = nlAfter[m
[31m-    for (i = 0; i < openParensBefore; i++) {[m
[31m-      cleanAfter = cleanAfter.replace(/\)[+*?]?/, '')[m
[31m-    }[m
[31m-    nlAfter = cleanAfter[m
[31m-[m
[31m-    var dollar = ''[m
[31m-    if (nlAfter === '' && isSub !== SUBPARSE) {[m
[31m-      dollar = '$'[m
[31m-    }[m
[31m-    var newRe = nlBefore + nlFirst + nlAfter + dollar + nlLast[m
[31m-    re = newRe[m
[31m-  }[m
[31m-[m
[31m-  // if the re is not "" at this point, then we need to make sure[m
[31m-  // it doesn't match against an empty path part.[m
[31m-  // Otherwise a/* will match a/, which it should not.[m
[31m-  if (re !== '' && hasMagic) {[m
[31m-    re = '(?=.)' + re[m
[31m-  }[m
[31m-[m
[31m-  if (addPatternStart) {[m
[31m-    re = patternStart + re[m
[31m-  }[m
[31m-[m
[31m-  // parsing just a piece of a larger pattern.[m
[31m-  if (isSub === SUBPARSE) {[m
[31m-    return [re, hasMagic][m
[31m-  }[m
[31m-[m
[31m-  // skip the regexp for non-magical patterns[m
[31m-  // unescape anything in it, though, so that it'll be[m
[31m-  // an exact match against a file etc.[m
[31m-  if (!hasMagic) {[m
[31m-    return globUnescape(pattern)[m
[31m-  }[m
[31m-[m
[31m-  var flags = options.nocase ? 'i' : ''[m
[31m-  try {[m
[31m-    var regExp = new RegExp('^' + re + '$', flags)[m
[31m-  } catch (er) {[m
[31m-    // If it was an invalid regular expression, then it can't match[m
[31m-    // anything.  This trick looks for a character after the end of[m
[31m-    // the string, which is of course impossible, except in multi-line[m
[31m-    // mode, but it's not a /m regex.[m
[31m-    return new RegExp('$.')[m
[31m-  }[m
[31m-[m
[31m-  regExp._glob = pattern[m
[31m-  regExp._src = re[m
[31m-[m
[31m-  return regExp[m
[31m-}[m
[31m-[m
[31m-minimatch.makeRe = function (pattern, options) {[m
[31m-  return new Minimatch(pattern, options || {}).makeRe()[m
[31m-}[m
[31m-[m
[31m-Minimatch.prototype.makeRe = makeRe[m
[31m-function makeRe () {[m
[31m-  if (this.regexp || this.regexp === false) return this.regexp[m
[31m-[m
[31m-  // at this point, this.set is a 2d array of partial[m
[31m-  // pattern strings, or "**".[m
[31m-  //[m
[31m-  // It's better to use .match().  This function shouldn't[m
[31m-  // be used, really, but it's pretty convenient sometimes,[m
[31m-  // when you just want to work with a regex.[m
[31m-  var set = this.set[m
[31m-[m
[31m-  if (!set.length) {[m
[31m-    this.regexp = false[m
[31m-    return this.regexp[m
[31m-  }[m
[31m-  var options = this.options[m
[31m-[m
[31m-  var twoStar = options.noglobstar ? star[m
[31m-    : options.dot ? twoStarDot[m
[31m-    : twoStarNoDot[m
[31m-  var flags = options.nocase ? 'i' : ''[m
[31m-[m
[31m-  var re = set.map(function (pattern) {[m
[31m-    return pattern.map(function (p) {[m
[31m-      return (p === GLOBSTAR) ? twoStar[m
[31m-      : (typeof p === 'string') ? regExpEscape(p)[m
[31m-      : p._src[m
[31m-    }).join('\\\/')[m
[31m-  }).join('|')[m
[31m-[m
[31m-  // must match entire pattern[m
[31m-  // ending in a * or ** will make it less strict.[m
[31m-  re = '^(?:' + re + ')$'[m
[31m-[m
[31m-  // can match anything, as long as it's not this.[m
[31m-  if (this.negate) re = '^(?!' + re + ').*$'[m
[31m-[m
[31m-  try {[m
[31m-    this.regexp = new RegExp(re, flags)[m
[31m-  } catch (ex) {[m
[31m-    this.regexp = false[m
[31m-  }[m
[31m-  return this.regexp[m
[31m-}[m
[31m-[m
[31m-minimatch.match = function (list, pattern, options) {[m
[31m-  options = options || {}[m
[31m-  var mm = new Minimatch(pattern, options)[m
[31m-  list = list.filter(function (f) {[m
[31m-    return mm.match(f)[m
[31m-  })[m
[31m-  if (mm.options.nonull && !list.length) {[m
[31m-    list.push(pattern)[m
[31m-  }[m
[31m-  return list[m
[31m-}[m
[31m-[m
[31m-Minimatch.prototype.match = match[m
[31m-function match (f, partial) {[m
[31m-  this.debug('match', f, this.pattern)[m
[31m-  // short-circuit in the case of busted things.[m
[31m-  // comments, etc.[m
[31m-  if (this.comment) return false[m
[31m-  if (this.empty) return f === ''[m
[31m-[m
[31m-  if (f === '/' && partial) return true[m
[31m-[m
[31m-  var options = this.options[m
[31m-[m
[31m-  // windows: need to use /, not \[m
[31m-  if (path.sep !== '/') {[m
[31m-    f = f.split(path.sep).join('/')[m
[31m-  }[m
[31m-[m
[31m-  // treat the test path as a set of pathparts.[m
[31m-  f = f.split(slashSplit)[m
[31m-  this.debug(this.pattern, 'split', f)[m
[31m-[m
[31m-  // just ONE of the pattern sets in this.set needs to match[m
[31m-  // in order for it to be valid.  If negating, then just one[m
[31m-  // match means that we have failed.[m
[31m-  // Either way, return on the first hit.[m
[31m-[m
[31m-  var set = this.set[m
[31m-  this.debug(this.pattern, 'set', set)[m
[31m-[m
[31m-  // Find the basename of the path by looking for the last non-empty segment[m
[31m-  var filename[m
[31m-  var i[m
[31m-  for (i = f.length - 1; i >= 0; i--) {[m
[31m-    filename = f[i][m
[31m-    if (filename) break[m
[31m-  }[m
[31m-[m
[31m-  for (i = 0; i < set.length; i++) {[m
[31m-    var pattern = set[i][m
[31m-    var file = f[m
[31m-    if (options.matchBase && pattern.length === 1) {[m
[31m-      file = [filename][m
[31m-    }[m
[31m-    var hit = this.matchOne(file, pattern, partial)[m
[31m-    if (hit) {[m
[31m-      if (options.flipNegate) return true[m
[31m-      return !this.negate[m
[31m-    }[m
[31m-  }[m
[31m-[m
[31m-  // didn't get any hits.  this is success if it's a negative[m
[31m-  // pattern, failure otherwise.[m
[31m-  if (options.flipNegate) return false[m
[31m-  return this.negate[m
[31m-}[m
[31m-[m
[31m-// set partial to true to test if, for example,[m
[31m-// "/a/b" matches the start of "/*/b/*/d"[m
[31m-// Partial means, if you run out of file before you run[m
[31m-// out of pattern, then that's fine, as long as all[m
[31m-// the parts match.[m
[31m-Minimatch.prototype.matchOne = function (file, pattern, partial) {[m
[31m-  var options = this.options[m
[31m-[m
[31m-  this.debug('matchOne',[m
[31m-    { 'this': this, file: file, pattern: pattern })[m
[31m-[m
[31m-  this.debug('matchOne', file.length, pattern.length)[m
[31m-[m
[31m-  for (var fi = 0,[m
[31m-      pi = 0,[m
[31m-      fl = file.length,[m
[31m-      pl = pattern.length[m
[31m-      ; (fi < fl) && (pi < pl)[m
[31m-      ; fi++, pi++) {[m
[31m-    this.debug('matchOne loop')[m
[31m-    var p = pattern[pi][m
[31m-    var f = file[fi][m
[31m-[m
[31m-    this.debug(pattern, p, f)[m
[31m-[m
[31m-    // should be impossible.[m
[31m-    // some invalid regexp stuff in the set.[m
[31m-    if (p === false) return false[m
[31m-[m
[31m-    if (p === GLOBSTAR) {[m
[31m-      this.debug('GLOBSTAR', [pattern, p, f])[m
[31m-[m
[31m-      // "**"[m
[31m-      // a/**/b/**/c would match the following:[m
[31m-      // a/b/x/y/z/c[m
[31m-      // a/x/y/z/b/c[m
[31m-      // a/b/x/b/x/c[m
[31m-      // a/b/c[m
[31m-      // To do this, take the rest of the pattern after[m
[31m-      // the **, and see if it would match the file remainder.[m
[31m-      // If so, return success.[m
[31m-      // If not, the ** "swallows" a segment, and try again.[m
[31m-      // This is recursively awful.[m
[31m-      //[m
[31m-      // a/**/b/**/c matching a/b/x/y/z/c[m
[31m-      // - a matches a[m
[31m-      // - doublestar[m
[31m-      //   - matchOne(b/x/y/z/c, b/**/c)[m
[31m-      //     - b matches b[m
[31m-      //     - doublestar[m
[31m-      //       - matchOne(x/y/z/c, c) -> no[m
[31m-      //       - matchOne(y/z/c, c) -> no[m
[31m-      //       - matchOne(z/c, c) -> no[m
[31m-      //       - matchOne(c, c) yes, hit[m
[31m-      var fr = fi[m
[31m-      var pr = pi + 1[m
[31m-      if (pr === pl) {[m
[31m-        this.debug('** at the end')[m
[31m-        // a ** at the end will just swallow the rest.[m
[31m-        // We have found a match.[m
[31m-        // however, it will not swallow /.x, unless[m
[31m-        // options.dot is set.[m
[31m-        // . and .. are *never* matched by **, for explosively[m
[31m-        // exponential reasons.[m
[31m-        for (; fi < fl; fi++) {[m
[31m-          if (file[fi] === '.' || file[fi] === '..' ||[m
[31m-            (!options.dot && file[fi].charAt(0) === '.')) return false[m
[31m-        }[m
[31m-        return true[m
[31m-      }[m
[31m-[m
[31m-      // ok, let's see if we can swallow whatever we can.[m
[31m-      while (fr < fl) {[m
[31m-        var swallowee = file[fr][m
[31m-[m
[31m-        this.debug('\nglobstar while', file, fr, pattern, pr, swallowee)[m
[31m-[m
[31m-        // XXX remove this slice.  Just pass the start index.[m
[31m-        if (this.matchOne(file.slice(fr), pattern.slice(pr), partial)) {[m
[31m-          this.debug('globstar found match!', fr, fl, swallowee)[m
[31m-          // found a match.[m
[31m-          return true[m
[31m-        } else {[m
[31m-          // can't swallow "." or ".." ever.[m
[31m-          // can only swallow ".foo" when explicitly asked.[m
[31m-          if (swallowee === '.' || swallowee === '..' ||[m
[31m-            (!options.dot && swallowee.charAt(0) === '.')) {[m
[31m-            this.debug('dot detected!', file, fr, pattern, pr)[m
[31m-            break[m
[31m-          }[m
[31m-[m
[31m-          // ** swallows a segment, and continue.[m
[31m-          this.debug('globstar swallow a segment, and continue')[m
[31m-          fr++[m
[31m-        }[m
[31m-      }[m
[31m-[m
[31m-      // no match was found.[m
[31m-      // However, in partial mode, we can't say this is necessarily over.[m
[31m-      // If there's more *pattern* left, then[m
[31m-      if (partial) {[m
[31m-        // ran out of file[m
[31m-        this.debug('\n>>> no match, partial?', file, fr, pattern, pr)[m
[31m-        if (fr === fl) return true[m
[31m-      }[m
[31m-      return false[m
[31m-    }[m
[31m-[m
[31m-    // something other than **[m
[31m-    // non-magic patterns just have to match exactly[m
[31m-    // patterns with magic have been turned into regexps.[m
[31m-    var hit[m
[31m-    if (typeof p === 'string') {[m
[31m-      if (options.nocase) {[m
[31m-        hit = f.toLowerCase() === p.toLowerCase()[m
[31m-      } else {[m
[31m-        hit = f === p[m
[31m-      }[m
[31m-      this.debug('string match', p, f, hit)[m
[31m-    } else {[m
[31m-      hit = f.match(p)[m
[31m-      this.debug('pattern match', p, f, hit)[m
[31m-    }[m
[31m-[m
[31m-    if (!hit) return false[m
[31m-  }[m
[31m-[m
[31m-  // Note: ending in / means that we'll get a final ""[m
[31m-  // at the end of the pattern.  This can only match a[m
[31m-  // corresponding "" at the end of the file.[m
[31m-  // If the file ends in /, then it can only match a[m
[31m-  // a pattern that ends in /, unless the pattern just[m
[31m-  // doesn't have any more for it. But, a/b/ should *not*[m
[31m-  // match "a/b/*", even though "" matches against the[m
[31m-  // [^/]*? pattern, except in partial mode, where it might[m
[31m-  // simply not be reached yet.[m
[31m-  // However, a/b/ should still satisfy a/*[m
[31m-[m
[31m-  // now either we fell off the end of the pattern, or we're done.[m
[31m-  if (fi === fl && pi === pl) {[m
[31m-    // ran out of pattern and filename at the same time.[m
[31m-    // an exact hit![m
[31m-    return true[m
[31m-  } else if (fi === fl) {[m
[31m-    // ran out of file, but still had pattern left.[m
[31m-    // this is ok if we're doing the match as part of[m
[31m-    // a glob fs traversal.[m
[31m-    return partial[m
[31m-  } else if (pi === pl) {[m
[31m-    // ran out of pattern, still have file left.[m
[31m-    // this is only acceptable if we're on the very last[m
[31m-    // empty segment of a file with a trailing slash.[m
[31m-    // a/* should match a/b/[m
[31m-    var emptyFileEnd = (fi === fl - 1) && (file[fi] === '')[m
[31m-    return emptyFileEnd[m
[31m-  }[m
[31m-[m
[31m-  // should be unreachable.[m
[31m-  throw new Error('wtf?')[m
[31m-}[m
[31m-[m
[31m-// replace stuff like \* with *[m
[31m-function globUnescape (s) {[m
[31m-  return s.replace(/\\(.)/g, '$1')[m
[31m-}[m
[31m-[m
[31m-function regExpEscape (s) {[m
[31m-  return s.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, '\\$&')[m
[31m-}[m
[31m-[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 6 */[m
[31m-/***/ (function(module, exports, __webpack_require__) {[m
[31m-[m
[31m-"use strict";[m
[31m-[m
[31m-[m
[31m-function posix(path) {[m
[31m-	return path.charAt(0) === '/';[m
[31m-}[m
[31m-[m
[31m-function win32(path) {[m
[31m-	// https://github.com/nodejs/node/blob/b3fcc245fb25539909ef1d5eaa01dbf92e168633/lib/path.js#L56[m
[31m-	var splitDeviceRe = /^([a-zA-Z]:|[\\\/]{2}[^\\\/]+[\\\/]+[^\\\/]+)?([\\\/])?([\s\S]*?)$/;[m
[31m-	var result = splitDeviceRe.exec(path);[m
[31m-	var device = result[1] || '';[m
[31m-	var isUnc = Boolean(device && device.charAt(1) !== ':');[m
[31m-[m
[31m-	// UNC paths are always absolute[m
[31m-	return Boolean(result[2] || isUnc);[m
[31m-}[m
[31m-[m
[31m-module.exports = process.platform === 'win32' ? win32 : posix;[m
[31m-module.exports.posix = posix;[m
[31m-module.exports.win32 = win32;[m
[31m-[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 7 */[m
[31m-/***/ (function(module, exports, __webpack_require__) {[m
[31m-[m
[31m-[m
[31m-/**[m
[31m- * This is the common logic for both the Node.js and web browser[m
[31m- * implementations of `debug()`.[m
[31m- *[m
[31m- * Expose `debug()` as the module.[m
[31m- */[m
[31m-[m
[31m-exports = module.exports = createDebug.debug = createDebug['default'] = createDebug;[m
[31m-exports.coerce = coerce;[m
[31m-exports.disable = disable;[m
[31m-exports.enable = enable;[m
[31m-exports.enabled = enabled;[m
[31m-exports.humanize = __webpack_require__(25);[m
[31m-[m
[31m-/**[m
[31m- * The currently active debug mode names, and names to skip.[m
[31m- */[m
[31m-[m
[31m-exports.names = [];[m
[31m-exports.skips = [];[m
[31m-[m
[31m-/**[m
[31m- * Map of special "%n" handling functions, for the debug "format" argument.[m
[31m- *[m
[31m- * Valid key names are a single, lower or upper-case letter, i.e. "n" and "N".[m
[31m- */[m
[31m-[m
[31m-exports.formatters = {};[m
[31m-[m
[31m-/**[m
[31m- * Previous log timestamp.[m
[31m- */[m
[31m-[m
[31m-var prevTime;[m
[31m-[m
[31m-/**[m
[31m- * Select a color.[m
[31m- * @param {String} namespace[m
[31m- * @return {Number}[m
[31m- * @api private[m
[31m- */[m
[31m-[m
[31m-function selectColor(namespace) {[m
[31m-  var hash = 0, i;[m
[31m-[m
[31m-  for (i in namespace) {[m
[31m-    hash  = ((hash << 5) - hash) + namespace.charCodeAt(i);[m
[31m-    hash |= 0; // Convert to 32bit integer[m
[31m-  }[m
[31m-[m
[31m-  return exports.colors[Math.abs(hash) % exports.colors.length];[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Create a debugger with the given `namespace`.[m
[31m- *[m
[31m- * @param {String} namespace[m
[31m- * @return {Function}[m
[31m- * @api public[m
[31m- */[m
[31m-[m
[31m-function createDebug(namespace) {[m
[31m-[m
[31m-  function debug() {[m
[31m-    // disabled?[m
[31m-    if (!debug.enabled) return;[m
[31m-[m
[31m-    var self = debug;[m
[31m-[m
[31m-    // set `diff` timestamp[m
[31m-    var curr = +new Date();[m
[31m-    var ms = curr - (prevTime || curr);[m
[31m-    self.diff = ms;[m
[31m-    self.prev = prevTime;[m
[31m-    self.curr = curr;[m
[31m-    prevTime = curr;[m
[31m-[m
[31m-    // turn the `arguments` into a proper Array[m
[31m-    var args = new Array(arguments.length);[m
[31m-    for (var i = 0; i < args.length; i++) {[m
[31m-      args[i] = arguments[i];[m
[31m-    }[m
[31m-[m
[31m-    args[0] = exports.coerce(args[0]);[m
[31m-[m
[31m-    if ('string' !== typeof args[0]) {[m
[31m-      // anything else let's inspect with %O[m
[31m-      args.unshift('%O');[m
[31m-    }[m
[31m-[m
[31m-    // apply any `formatters` transformations[m
[31m-    var index = 0;[m
[31m-    args[0] = args[0].replace(/%([a-zA-Z%])/g, function(match, format) {[m
[31m-      // if we encounter an escaped % then don't increase the array index[m
[31m-      if (match === '%%') return match;[m
[31m-      index++;[m
[31m-      var formatter = exports.formatters[format];[m
[31m-      if ('function' === typeof formatter) {[m
[31m-        var val = args[index];[m
[31m-        match = formatter.call(self, val);[m
[31m-[m
[31m-        // now we need to remove `args[index]` since it's inlined in the `format`[m
[31m-        args.splice(index, 1);[m
[31m-        index--;[m
[31m-      }[m
[31m-      return match;[m
[31m-    });[m
[31m-[m
[31m-    // apply env-specific formatting (colors, etc.)[m
[31m-    exports.formatArgs.call(self, args);[m
[31m-[m
[31m-    var logFn = debug.log || exports.log || console.log.bind(console);[m
[31m-    logFn.apply(self, args);[m
[31m-  }[m
[31m-[m
[31m-  debug.namespace = namespace;[m
[31m-  debug.enabled = exports.enabled(namespace);[m
[31m-  debug.useColors = exports.useColors();[m
[31m-  debug.color = selectColor(namespace);[m
[31m-[m
[31m-  // env-specific initialization logic for debug instances[m
[31m-  if ('function' === typeof exports.init) {[m
[31m-    exports.init(debug);[m
[31m-  }[m
[31m-[m
[31m-  return debug;[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Enables a debug mode by namespaces. This can include modes[m
[31m- * separated by a colon and wildcards.[m
[31m- *[m
[31m- * @param {String} namespaces[m
[31m- * @api public[m
[31m- */[m
[31m-[m
[31m-function enable(namespaces) {[m
[31m-  exports.save(namespaces);[m
[31m-[m
[31m-  exports.names = [];[m
[31m-  exports.skips = [];[m
[31m-[m
[31m-  var split = (typeof namespaces === 'string' ? namespaces : '').split(/[\s,]+/);[m
[31m-  var len = split.length;[m
[31m-[m
[31m-  for (var i = 0; i < len; i++) {[m
[31m-    if (!split[i]) continue; // ignore empty strings[m
[31m-    namespaces = split[i].replace(/\*/g, '.*?');[m
[31m-    if (namespaces[0] === '-') {[m
[31m-      exports.skips.push(new RegExp('^' + namespaces.substr(1) + '$'));[m
[31m-    } else {[m
[31m-      exports.names.push(new RegExp('^' + namespaces + '$'));[m
[31m-    }[m
[31m-  }[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Disable debug output.[m
[31m- *[m
[31m- * @api public[m
[31m- */[m
[31m-[m
[31m-function disable() {[m
[31m-  exports.enable('');[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Returns true if the given mode name is enabled, false otherwise.[m
[31m- *[m
[31m- * @param {String} name[m
[31m- * @return {Boolean}[m
[31m- * @api public[m
[31m- */[m
[31m-[m
[31m-function enabled(name) {[m
[31m-  var i, len;[m
[31m-  for (i = 0, len = exports.skips.length; i < len; i++) {[m
[31m-    if (exports.skips[i].test(name)) {[m
[31m-      return false;[m
[31m-    }[m
[31m-  }[m
[31m-  for (i = 0, len = exports.names.length; i < len; i++) {[m
[31m-    if (exports.names[i].test(name)) {[m
[31m-      return true;[m
[31m-    }[m
[31m-  }[m
[31m-  return false;[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Coerce `val`.[m
[31m- *[m
[31m- * @param {Mixed} val[m
[31m- * @return {Mixed}[m
[31m- * @api private[m
[31m- */[m
[31m-[m
[31m-function coerce(val) {[m
[31m-  if (val instanceof Error) return val.stack || val.message;[m
[31m-  return val;[m
[31m-}[m
[31m-[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 8 */[m
[31m-/***/ (function(module, exports) {[m
[31m-[m
[31m-function webpackEmptyContext(req) {[m
[31m-	throw new Error("Cannot find module '" + req + "'.");[m
[31m-}[m
[31m-webpackEmptyContext.keys = function() { return []; };[m
[31m-webpackEmptyContext.resolve = webpackEmptyContext;[m
[31m-module.exports = webpackEmptyContext;[m
[31m-webpackEmptyContext.id = 8;[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 9 */[m
[31m-/***/ (function(module, exports, __webpack_require__) {[m
[31m-[m
[31m-// Approach:[m
[31m-//[m
[31m-// 1. Get the minimatch set[m
[31m-// 2. For each pattern in the set, PROCESS(pattern, false)[m
[31m-// 3. Store matches per-set, then uniq them[m
[31m-//[m
[31m-// PROCESS(pattern, inGlobStar)[m
[31m-// Get the first [n] items from pattern that are all strings[m
[31m-// Join these together.  This is PREFIX.[m
[31m-//   If there is no more remaining, then stat(PREFIX) and[m
[31m-//   add to matches if it succeeds.  END.[m
[31m-//[m
[31m-// If inGlobStar and PREFIX is symlink and points to dir[m
[31m-//   set ENTRIES = [][m
[31m-// else readdir(PREFIX) as ENTRIES[m
[31m-//   If fail, END[m
[31m-//[m
[31m-// with ENTRIES[m
[31m-//   If pattern[n] is GLOBSTAR[m
[31m-//     // handle the case where the globstar match is empty[m
[31m-//     // by pruning it out, and testing the resulting pattern[m
[31m-//     PROCESS(pattern[0..n] + pattern[n+1 .. $], false)[m
[31m-//     // handle other cases.[m
[31m-//     for ENTRY in ENTRIES (not dotfiles)[m
[31m-//       // attach globstar + tail onto the entry[m
[31m-//       // Mark that this entry is a globstar match[m
[31m-//       PROCESS(pattern[0..n] + ENTRY + pattern[n .. $], true)[m
[31m-//[m
[31m-//   else // not globstar[m
[31m-//     for ENTRY in ENTRIES (not dotfiles, unless pattern[n] is dot)[m
[31m-//       Test ENTRY against pattern[n][m
[31m-//       If fails, continue[m
[31m-//       If passes, PROCESS(pattern[0..n] + item + pattern[n+1 .. $])[m
[31m-//[m
[31m-// Caveat:[m
[31m-//   Cache all stats and readdirs results to minimize syscall.  Since all[m
[31m-//   we ever care about is existence and directory-ness, we can just keep[m
[31m-//   `true` for files, and [children,...] for directories, or `false` for[m
[31m-//   things that don't exist.[m
[31m-[m
[31m-module.exports = glob[m
[31m-[m
[31m-var fs = __webpack_require__(1)[m
[31m-var rp = __webpack_require__(10)[m
[31m-var minimatch = __webpack_require__(5)[m
[31m-var Minimatch = minimatch.Minimatch[m
[31m-var inherits = __webpack_require__(38)[m
[31m-var EE = __webpack_require__(40).EventEmitter[m
[31m-var path = __webpack_require__(0)[m
[31m-var assert = __webpack_require__(4)[m
[31m-var isAbsolute = __webpack_require__(6)[m
[31m-var globSync = __webpack_require__(41)[m
[31m-var common = __webpack_require__(11)[m
[31m-var alphasort = common.alphasort[m
[31m-var alphasorti = common.alphasorti[m
[31m-var setopts = common.setopts[m
[31m-var ownProp = common.ownProp[m
[31m-var inflight = __webpack_require__(42)[m
[31m-var util = __webpack_require__(3)[m
[31m-var childrenIgnored = common.childrenIgnored[m
[31m-var isIgnored = common.isIgnored[m
[31m-[m
[31m-var once = __webpack_require__(13)[m
[31m-[m
[31m-function glob (pattern, options, cb) {[m
[31m-  if (typeof options === 'function') cb = options, options = {}[m
[31m-  if (!options) options = {}[m
[31m-[m
[31m-  if (options.sync) {[m
[31m-    if (cb)[m
[31m-      throw new TypeError('callback provided to sync glob')[m
[31m-    return globSync(pattern, options)[m
[31m-  }[m
[31m-[m
[31m-  return new Glob(pattern, options, cb)[m
[31m-}[m
[31m-[m
[31m-glob.sync = globSync[m
[31m-var GlobSync = glob.GlobSync = globSync.GlobSync[m
[31m-[m
[31m-// old api surface[m
[31m-glob.glob = glob[m
[31m-[m
[31m-function extend (origin, add) {[m
[31m-  if (add === null || typeof add !== 'object') {[m
[31m-    return origin[m
[31m-  }[m
[31m-[m
[31m-  var keys = Object.keys(add)[m
[31m-  var i = keys.length[m
[31m-  while (i--) {[m
[31m-    origin[keys[i]] = add[keys[i]][m
[31m-  }[m
[31m-  return origin[m
[31m-}[m
[31m-[m
[31m-glob.hasMagic = function (pattern, options_) {[m
[31m-  var options = extend({}, options_)[m
[31m-  options.noprocess = true[m
[31m-[m
[31m-  var g = new Glob(pattern, options)[m
[31m-  var set = g.minimatch.set[m
[31m-[m
[31m-  if (!pattern)[m
[31m-    return false[m
[31m-[m
[31m-  if (set.length > 1)[m
[31m-    return true[m
[31m-[m
[31m-  for (var j = 0; j < set[0].length; j++) {[m
[31m-    if (typeof set[0][j] !== 'string')[m
[31m-      return true[m
[31m-  }[m
[31m-[m
[31m-  return false[m
[31m-}[m
[31m-[m
[31m-glob.Glob = Glob[m
[31m-inherits(Glob, EE)[m
[31m-function Glob (pattern, options, cb) {[m
[31m-  if (typeof options === 'function') {[m
[31m-    cb = options[m
[31m-    options = null[m
[31m-  }[m
[31m-[m
[31m-  if (options && options.sync) {[m
[31m-    if (cb)[m
[31m-      throw new TypeError('callback provided to sync glob')[m
[31m-    return new GlobSync(pattern, options)[m
[31m-  }[m
[31m-[m
[31m-  if (!(this instanceof Glob))[m
[31m-    return new Glob(pattern, options, cb)[m
[31m-[m
[31m-  setopts(this, pattern, options)[m
[31m-  this._didRealPath = false[m
[31m-[m
[31m-  // process each pattern in the minimatch set[m
[31m-  var n = this.minimatch.set.length[m
[31m-[m
[31m-  // The matches are stored as {<filename>: true,...} so that[m
[31m-  // duplicates are automagically pruned.[m
[31m-  // Later, we do an Object.keys() on these.[m
[31m-  // Keep them as a list so we can fill in when nonull is set.[m
[31m-  this.matches = new Array(n)[m
[31m-[m
[31m-  if (typeof cb === 'function') {[m
[31m-    cb = once(cb)[m
[31m-    this.on('error', cb)[m
[31m-    this.on('end', function (matches) {[m
[31m-      cb(null, matches)[m
[31m-    })[m
[31m-  }[m
[31m-[m
[31m-  var self = this[m
[31m-  this._processing = 0[m
[31m-[m
[31m-  this._emitQueue = [][m
[31m-  this._processQueue = [][m
[31m-  this.paused = false[m
[31m-[m
[31m-  if (this.noprocess)[m
[31m-    return this[m
[31m-[m
[31m-  if (n === 0)[m
[31m-    return done()[m
[31m-[m
[31m-  var sync = true[m
[31m-  for (var i = 0; i < n; i ++) {[m
[31m-    this._process(this.minimatch.set[i], i, false, done)[m
[31m-  }[m
[31m-  sync = false[m
[31m-[m
[31m-  function done () {[m
[31m-    --self._processing[m
[31m-    if (self._processing <= 0) {[m
[31m-      if (sync) {[m
[31m-        process.nextTick(function () {[m
[31m-          self._finish()[m
[31m-        })[m
[31m-      } else {[m
[31m-        self._finish()[m
[31m-      }[m
[31m-    }[m
[31m-  }[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._finish = function () {[m
[31m-  assert(this instanceof Glob)[m
[31m-  if (this.aborted)[m
[31m-    return[m
[31m-[m
[31m-  if (this.realpath && !this._didRealpath)[m
[31m-    return this._realpath()[m
[31m-[m
[31m-  common.finish(this)[m
[31m-  this.emit('end', this.found)[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._realpath = function () {[m
[31m-  if (this._didRealpath)[m
[31m-    return[m
[31m-[m
[31m-  this._didRealpath = true[m
[31m-[m
[31m-  var n = this.matches.length[m
[31m-  if (n === 0)[m
[31m-    return this._finish()[m
[31m-[m
[31m-  var self = this[m
[31m-  for (var i = 0; i < this.matches.length; i++)[m
[31m-    this._realpathSet(i, next)[m
[31m-[m
[31m-  function next () {[m
[31m-    if (--n === 0)[m
[31m-      self._finish()[m
[31m-  }[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._realpathSet = function (index, cb) {[m
[31m-  var matchset = this.matches[index][m
[31m-  if (!matchset)[m
[31m-    return cb()[m
[31m-[m
[31m-  var found = Object.keys(matchset)[m
[31m-  var self = this[m
[31m-  var n = found.length[m
[31m-[m
[31m-  if (n === 0)[m
[31m-    return cb()[m
[31m-[m
[31m-  var set = this.matches[index] = Object.create(null)[m
[31m-  found.forEach(function (p, i) {[m
[31m-    // If there's a problem with the stat, then it means that[m
[31m-    // one or more of the links in the realpath couldn't be[m
[31m-    // resolved.  just return the abs value in that case.[m
[31m-    p = self._makeAbs(p)[m
[31m-    rp.realpath(p, self.realpathCache, function (er, real) {[m
[31m-      if (!er)[m
[31m-        set[real] = true[m
[31m-      else if (er.syscall === 'stat')[m
[31m-        set[p] = true[m
[31m-      else[m
[31m-        self.emit('error', er) // srsly wtf right here[m
[31m-[m
[31m-      if (--n === 0) {[m
[31m-        self.matches[index] = set[m
[31m-        cb()[m
[31m-      }[m
[31m-    })[m
[31m-  })[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._mark = function (p) {[m
[31m-  return common.mark(this, p)[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._makeAbs = function (f) {[m
[31m-  return common.makeAbs(this, f)[m
[31m-}[m
[31m-[m
[31m-Glob.prototype.abort = function () {[m
[31m-  this.aborted = true[m
[31m-  this.emit('abort')[m
[31m-}[m
[31m-[m
[31m-Glob.prototype.pause = function () {[m
[31m-  if (!this.paused) {[m
[31m-    this.paused = true[m
[31m-    this.emit('pause')[m
[31m-  }[m
[31m-}[m
[31m-[m
[31m-Glob.prototype.resume = function () {[m
[31m-  if (this.paused) {[m
[31m-    this.emit('resume')[m
[31m-    this.paused = false[m
[31m-    if (this._emitQueue.length) {[m
[31m-      var eq = this._emitQueue.slice(0)[m
[31m-      this._emitQueue.length = 0[m
[31m-      for (var i = 0; i < eq.length; i ++) {[m
[31m-        var e = eq[i][m
[31m-        this._emitMatch(e[0], e[1])[m
[31m-      }[m
[31m-    }[m
[31m-    if (this._processQueue.length) {[m
[31m-      var pq = this._processQueue.slice(0)[m
[31m-      this._processQueue.length = 0[m
[31m-      for (var i = 0; i < pq.length; i ++) {[m
[31m-        var p = pq[i][m
[31m-        this._processing--[m
[31m-        this._process(p[0], p[1], p[2], p[3])[m
[31m-      }[m
[31m-    }[m
[31m-  }[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._process = function (pattern, index, inGlobStar, cb) {[m
[31m-  assert(this instanceof Glob)[m
[31m-  assert(typeof cb === 'function')[m
[31m-[m
[31m-  if (this.aborted)[m
[31m-    return[m
[31m-[m
[31m-  this._processing++[m
[31m-  if (this.paused) {[m
[31m-    this._processQueue.push([pattern, index, inGlobStar, cb])[m
[31m-    return[m
[31m-  }[m
[31m-[m
[31m-  //console.error('PROCESS %d', this._processing, pattern)[m
[31m-[m
[31m-  // Get the first [n] parts of pattern that are all strings.[m
[31m-  var n = 0[m
[31m-  while (typeof pattern[n] === 'string') {[m
[31m-    n ++[m
[31m-  }[m
[31m-  // now n is the index of the first one that is *not* a string.[m
[31m-[m
[31m-  // see if there's anything else[m
[31m-  var prefix[m
[31m-  switch (n) {[m
[31m-    // if not, then this is rather simple[m
[31m-    case pattern.length:[m
[31m-      this._processSimple(pattern.join('/'), index, cb)[m
[31m-      return[m
[31m-[m
[31m-    case 0:[m
[31m-      // pattern *starts* with some non-trivial item.[m
[31m-      // going to readdir(cwd), but not include the prefix in matches.[m
[31m-      prefix = null[m
[31m-      break[m
[31m-[m
[31m-    default:[m
[31m-      // pattern has some string bits in the front.[m
[31m-      // whatever it starts with, whether that's 'absolute' like /foo/bar,[m
[31m-      // or 'relative' like '../baz'[m
[31m-      prefix = pattern.slice(0, n).join('/')[m
[31m-      break[m
[31m-  }[m
[31m-[m
[31m-  var remain = pattern.slice(n)[m
[31m-[m
[31m-  // get the list of entries.[m
[31m-  var read[m
[31m-  if (prefix === null)[m
[31m-    read = '.'[m
[31m-  else if (isAbsolute(prefix) || isAbsolute(pattern.join('/'))) {[m
[31m-    if (!prefix || !isAbsolute(prefix))[m
[31m-      prefix = '/' + prefix[m
[31m-    read = prefix[m
[31m-  } else[m
[31m-    read = prefix[m
[31m-[m
[31m-  var abs = this._makeAbs(read)[m
[31m-[m
[31m-  //if ignored, skip _processing[m
[31m-  if (childrenIgnored(this, read))[m
[31m-    return cb()[m
[31m-[m
[31m-  var isGlobStar = remain[0] === minimatch.GLOBSTAR[m
[31m-  if (isGlobStar)[m
[31m-    this._processGlobStar(prefix, read, abs, remain, index, inGlobStar, cb)[m
[31m-  else[m
[31m-    this._processReaddir(prefix, read, abs, remain, index, inGlobStar, cb)[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._processReaddir = function (prefix, read, abs, remain, index, inGlobStar, cb) {[m
[31m-  var self = this[m
[31m-  this._readdir(abs, inGlobStar, function (er, entries) {[m
[31m-    return self._processReaddir2(prefix, read, abs, remain, index, inGlobStar, entries, cb)[m
[31m-  })[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._processReaddir2 = function (prefix, read, abs, remain, index, inGlobStar, entries, cb) {[m
[31m-[m
[31m-  // if the abs isn't a dir, then nothing can match![m
[31m-  if (!entries)[m
[31m-    return cb()[m
[31m-[m
[31m-  // It will only match dot entries if it starts with a dot, or if[m
[31m-  // dot is set.  Stuff like @(.foo|.bar) isn't allowed.[m
[31m-  var pn = remain[0][m
[31m-  var negate = !!this.minimatch.negate[m
[31m-  var rawGlob = pn._glob[m
[31m-  var dotOk = this.dot || rawGlob.charAt(0) === '.'[m
[31m-[m
[31m-  var matchedEntries = [][m
[31m-  for (var i = 0; i < entries.length; i++) {[m
[31m-    var e = entries[i][m
[31m-    if (e.charAt(0) !== '.' || dotOk) {[m
[31m-      var m[m
[31m-      if (negate && !prefix) {[m
[31m-        m = !e.match(pn)[m
[31m-      } else {[m
[31m-        m = e.match(pn)[m
[31m-      }[m
[31m-      if (m)[m
[31m-        matchedEntries.push(e)[m
[31m-    }[m
[31m-  }[m
[31m-[m
[31m-  //console.error('prd2', prefix, entries, remain[0]._glob, matchedEntries)[m
[31m-[m
[31m-  var len = matchedEntries.length[m
[31m-  // If there are no matched entries, then nothing matches.[m
[31m-  if (len === 0)[m
[31m-    return cb()[m
[31m-[m
[31m-  // if this is the last remaining pattern bit, then no need for[m
[31m-  // an additional stat *unless* the user has specified mark or[m
[31m-  // stat explicitly.  We know they exist, since readdir returned[m
[31m-  // them.[m
[31m-[m
[31m-  if (remain.length === 1 && !this.mark && !this.stat) {[m
[31m-    if (!this.matches[index])[m
[31m-      this.matches[index] = Object.create(null)[m
[31m-[m
[31m-    for (var i = 0; i < len; i ++) {[m
[31m-      var e = matchedEntries[i][m
[31m-      if (prefix) {[m
[31m-        if (prefix !== '/')[m
[31m-          e = prefix + '/' + e[m
[31m-        else[m
[31m-          e = prefix + e[m
[31m-      }[m
[31m-[m
[31m-      if (e.charAt(0) === '/' && !this.nomount) {[m
[31m-        e = path.join(this.root, e)[m
[31m-      }[m
[31m-      this._emitMatch(index, e)[m
[31m-    }[m
[31m-    // This was the last one, and no stats were needed[m
[31m-    return cb()[m
[31m-  }[m
[31m-[m
[31m-  // now test all matched entries as stand-ins for that part[m
[31m-  // of the pattern.[m
[31m-  remain.shift()[m
[31m-  for (var i = 0; i < len; i ++) {[m
[31m-    var e = matchedEntries[i][m
[31m-    var newPattern[m
[31m-    if (prefix) {[m
[31m-      if (prefix !== '/')[m
[31m-        e = prefix + '/' + e[m
[31m-      else[m
[31m-        e = prefix + e[m
[31m-    }[m
[31m-    this._process([e].concat(remain), index, inGlobStar, cb)[m
[31m-  }[m
[31m-  cb()[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._emitMatch = function (index, e) {[m
[31m-  if (this.aborted)[m
[31m-    return[m
[31m-[m
[31m-  if (isIgnored(this, e))[m
[31m-    return[m
[31m-[m
[31m-  if (this.paused) {[m
[31m-    this._emitQueue.push([index, e])[m
[31m-    return[m
[31m-  }[m
[31m-[m
[31m-  var abs = isAbsolute(e) ? e : this._makeAbs(e)[m
[31m-[m
[31m-  if (this.mark)[m
[31m-    e = this._mark(e)[m
[31m-[m
[31m-  if (this.absolute)[m
[31m-    e = abs[m
[31m-[m
[31m-  if (this.matches[index][e])[m
[31m-    return[m
[31m-[m
[31m-  if (this.nodir) {[m
[31m-    var c = this.cache[abs][m
[31m-    if (c === 'DIR' || Array.isArray(c))[m
[31m-      return[m
[31m-  }[m
[31m-[m
[31m-  this.matches[index][e] = true[m
[31m-[m
[31m-  var st = this.statCache[abs][m
[31m-  if (st)[m
[31m-    this.emit('stat', e, st)[m
[31m-[m
[31m-  this.emit('match', e)[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._readdirInGlobStar = function (abs, cb) {[m
[31m-  if (this.aborted)[m
[31m-    return[m
[31m-[m
[31m-  // follow all symlinked directories forever[m
[31m-  // just proceed as if this is a non-globstar situation[m
[31m-  if (this.follow)[m
[31m-    return this._readdir(abs, false, cb)[m
[31m-[m
[31m-  var lstatkey = 'lstat\0' + abs[m
[31m-  var self = this[m
[31m-  var lstatcb = inflight(lstatkey, lstatcb_)[m
[31m-[m
[31m-  if (lstatcb)[m
[31m-    fs.lstat(abs, lstatcb)[m
[31m-[m
[31m-  function lstatcb_ (er, lstat) {[m
[31m-    if (er && er.code === 'ENOENT')[m
[31m-      return cb()[m
[31m-[m
[31m-    var isSym = lstat && lstat.isSymbolicLink()[m
[31m-    self.symlinks[abs] = isSym[m
[31m-[m
[31m-    // If it's not a symlink or a dir, then it's definitely a regular file.[m
[31m-    // don't bother doing a readdir in that case.[m
[31m-    if (!isSym && lstat && !lstat.isDirectory()) {[m
[31m-      self.cache[abs] = 'FILE'[m
[31m-      cb()[m
[31m-    } else[m
[31m-      self._readdir(abs, false, cb)[m
[31m-  }[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._readdir = function (abs, inGlobStar, cb) {[m
[31m-  if (this.aborted)[m
[31m-    return[m
[31m-[m
[31m-  cb = inflight('readdir\0'+abs+'\0'+inGlobStar, cb)[m
[31m-  if (!cb)[m
[31m-    return[m
[31m-[m
[31m-  //console.error('RD %j %j', +inGlobStar, abs)[m
[31m-  if (inGlobStar && !ownProp(this.symlinks, abs))[m
[31m-    return this._readdirInGlobStar(abs, cb)[m
[31m-[m
[31m-  if (ownProp(this.cache, abs)) {[m
[31m-    var c = this.cache[abs][m
[31m-    if (!c || c === 'FILE')[m
[31m-      return cb()[m
[31m-[m
[31m-    if (Array.isArray(c))[m
[31m-      return cb(null, c)[m
[31m-  }[m
[31m-[m
[31m-  var self = this[m
[31m-  fs.readdir(abs, readdirCb(this, abs, cb))[m
[31m-}[m
[31m-[m
[31m-function readdirCb (self, abs, cb) {[m
[31m-  return function (er, entries) {[m
[31m-    if (er)[m
[31m-      self._readdirError(abs, er, cb)[m
[31m-    else[m
[31m-      self._readdirEntries(abs, entries, cb)[m
[31m-  }[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._readdirEntries = function (abs, entries, cb) {[m
[31m-  if (this.aborted)[m
[31m-    return[m
[31m-[m
[31m-  // if we haven't asked to stat everything, then just[m
[31m-  // assume that everything in there exists, so we can avoid[m
[31m-  // having to stat it a second time.[m
[31m-  if (!this.mark && !this.stat) {[m
[31m-    for (var i = 0; i < entries.length; i ++) {[m
[31m-      var e = entries[i][m
[31m-      if (abs === '/')[m
[31m-        e = abs + e[m
[31m-      else[m
[31m-        e = abs + '/' + e[m
[31m-      this.cache[e] = true[m
[31m-    }[m
[31m-  }[m
[31m-[m
[31m-  this.cache[abs] = entries[m
[31m-  return cb(null, entries)[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._readdirError = function (f, er, cb) {[m
[31m-  if (this.aborted)[m
[31m-    return[m
[31m-[m
[31m-  // handle errors, and cache the information[m
[31m-  switch (er.code) {[m
[31m-    case 'ENOTSUP': // https://github.com/isaacs/node-glob/issues/205[m
[31m-    case 'ENOTDIR': // totally normal. means it *does* exist.[m
[31m-      var abs = this._makeAbs(f)[m
[31m-      this.cache[abs] = 'FILE'[m
[31m-      if (abs === this.cwdAbs) {[m
[31m-        var error = new Error(er.code + ' invalid cwd ' + this.cwd)[m
[31m-        error.path = this.cwd[m
[31m-        error.code = er.code[m
[31m-        this.emit('error', error)[m
[31m-        this.abort()[m
[31m-      }[m
[31m-      break[m
[31m-[m
[31m-    case 'ENOENT': // not terribly unusual[m
[31m-    case 'ELOOP':[m
[31m-    case 'ENAMETOOLONG':[m
[31m-    case 'UNKNOWN':[m
[31m-      this.cache[this._makeAbs(f)] = false[m
[31m-      break[m
[31m-[m
[31m-    default: // some unusual error.  Treat as failure.[m
[31m-      this.cache[this._makeAbs(f)] = false[m
[31m-      if (this.strict) {[m
[31m-        this.emit('error', er)[m
[31m-        // If the error is handled, then we abort[m
[31m-        // if not, we threw out of here[m
[31m-        this.abort()[m
[31m-      }[m
[31m-      if (!this.silent)[m
[31m-        console.error('glob error', er)[m
[31m-      break[m
[31m-  }[m
[31m-[m
[31m-  return cb()[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._processGlobStar = function (prefix, read, abs, remain, index, inGlobStar, cb) {[m
[31m-  var self = this[m
[31m-  this._readdir(abs, inGlobStar, function (er, entries) {[m
[31m-    self._processGlobStar2(prefix, read, abs, remain, index, inGlobStar, entries, cb)[m
[31m-  })[m
[31m-}[m
[31m-[m
[31m-[m
[31m-Glob.prototype._processGlobStar2 = function (prefix, read, abs, remain, index, inGlobStar, entries, cb) {[m
[31m-  //console.error('pgs2', prefix, remain[0], entries)[m
[31m-[m
[31m-  // no entries means not a dir, so it can never have matches[m
[31m-  // foo.txt/** doesn't match foo.txt[m
[31m-  if (!entries)[m
[31m-    return cb()[m
[31m-[m
[31m-  // test without the globstar, and with every child both below[m
[31m-  // and replacing the globstar.[m
[31m-  var remainWithoutGlobStar = remain.slice(1)[m
[31m-  var gspref = prefix ? [ prefix ] : [][m
[31m-  var noGlobStar = gspref.concat(remainWithoutGlobStar)[m
[31m-[m
[31m-  // the noGlobStar pattern exits the inGlobStar state[m
[31m-  this._process(noGlobStar, index, false, cb)[m
[31m-[m
[31m-  var isSym = this.symlinks[abs][m
[31m-  var len = entries.length[m
[31m-[m
[31m-  // If it's a symlink, and we're in a globstar, then stop[m
[31m-  if (isSym && inGlobStar)[m
[31m-    return cb()[m
[31m-[m
[31m-  for (var i = 0; i < len; i++) {[m
[31m-    var e = entries[i][m
[31m-    if (e.charAt(0) === '.' && !this.dot)[m
[31m-      continue[m
[31m-[m
[31m-    // these two cases enter the inGlobStar state[m
[31m-    var instead = gspref.concat(entries[i], remainWithoutGlobStar)[m
[31m-    this._process(instead, index, true, cb)[m
[31m-[m
[31m-    var below = gspref.concat(entries[i], remain)[m
[31m-    this._process(below, index, true, cb)[m
[31m-  }[m
[31m-[m
[31m-  cb()[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._processSimple = function (prefix, index, cb) {[m
[31m-  // XXX review this.  Shouldn't it be doing the mounting etc[m
[31m-  // before doing stat?  kinda weird?[m
[31m-  var self = this[m
[31m-  this._stat(prefix, function (er, exists) {[m
[31m-    self._processSimple2(prefix, index, er, exists, cb)[m
[31m-  })[m
[31m-}[m
[31m-Glob.prototype._processSimple2 = function (prefix, index, er, exists, cb) {[m
[31m-[m
[31m-  //console.error('ps2', prefix, exists)[m
[31m-[m
[31m-  if (!this.matches[index])[m
[31m-    this.matches[index] = Object.create(null)[m
[31m-[m
[31m-  // If it doesn't exist, then just mark the lack of results[m
[31m-  if (!exists)[m
[31m-    return cb()[m
[31m-[m
[31m-  if (prefix && isAbsolute(prefix) && !this.nomount) {[m
[31m-    var trail = /[\/\\]$/.test(prefix)[m
[31m-    if (prefix.charAt(0) === '/') {[m
[31m-      prefix = path.join(this.root, prefix)[m
[31m-    } else {[m
[31m-      prefix = path.resolve(this.root, prefix)[m
[31m-      if (trail)[m
[31m-        prefix += '/'[m
[31m-    }[m
[31m-  }[m
[31m-[m
[31m-  if (process.platform === 'win32')[m
[31m-    prefix = prefix.replace(/\\/g, '/')[m
[31m-[m
[31m-  // Mark this as a match[m
[31m-  this._emitMatch(index, prefix)[m
[31m-  cb()[m
[31m-}[m
[31m-[m
[31m-// Returns either 'DIR', 'FILE', or false[m
[31m-Glob.prototype._stat = function (f, cb) {[m
[31m-  var abs = this._makeAbs(f)[m
[31m-  var needDir = f.slice(-1) === '/'[m
[31m-[m
[31m-  if (f.length > this.maxLength)[m
[31m-    return cb()[m
[31m-[m
[31m-  if (!this.stat && ownProp(this.cache, abs)) {[m
[31m-    var c = this.cache[abs][m
[31m-[m
[31m-    if (Array.isArray(c))[m
[31m-      c = 'DIR'[m
[31m-[m
[31m-    // It exists, but maybe not how we need it[m
[31m-    if (!needDir || c === 'DIR')[m
[31m-      return cb(null, c)[m
[31m-[m
[31m-    if (needDir && c === 'FILE')[m
[31m-      return cb()[m
[31m-[m
[31m-    // otherwise we have to stat, because maybe c=true[m
[31m-    // if we know it exists, but not what it is.[m
[31m-  }[m
[31m-[m
[31m-  var exists[m
[31m-  var stat = this.statCache[abs][m
[31m-  if (stat !== undefined) {[m
[31m-    if (stat === false)[m
[31m-      return cb(null, stat)[m
[31m-    else {[m
[31m-      var type = stat.isDirectory() ? 'DIR' : 'FILE'[m
[31m-      if (needDir && type === 'FILE')[m
[31m-        return cb()[m
[31m-      else[m
[31m-        return cb(null, type, stat)[m
[31m-    }[m
[31m-  }[m
[31m-[m
[31m-  var self = this[m
[31m-  var statcb = inflight('stat\0' + abs, lstatcb_)[m
[31m-  if (statcb)[m
[31m-    fs.lstat(abs, statcb)[m
[31m-[m
[31m-  function lstatcb_ (er, lstat) {[m
[31m-    if (lstat && lstat.isSymbolicLink()) {[m
[31m-      // If it's a symlink, then treat it as the target, unless[m
[31m-      // the target does not exist, then treat it as a file.[m
[31m-      return fs.stat(abs, function (er, stat) {[m
[31m-        if (er)[m
[31m-          self._stat2(f, abs, null, lstat, cb)[m
[31m-        else[m
[31m-          self._stat2(f, abs, er, stat, cb)[m
[31m-      })[m
[31m-    } else {[m
[31m-      self._stat2(f, abs, er, lstat, cb)[m
[31m-    }[m
[31m-  }[m
[31m-}[m
[31m-[m
[31m-Glob.prototype._stat2 = function (f, abs, er, stat, cb) {[m
[31m-  if (er && (er.code === 'ENOENT' || er.code === 'ENOTDIR')) {[m
[31m-    this.statCache[abs] = false[m
[31m-    return cb()[m
[31m-  }[m
[31m-[m
[31m-  var needDir = f.slice(-1) === '/'[m
[31m-  this.statCache[abs] = stat[m
[31m-[m
[31m-  if (abs.slice(-1) === '/' && stat && !stat.isDirectory())[m
[31m-    return cb(null, false, stat)[m
[31m-[m
[31m-  var c = true[m
[31m-  if (stat)[m
[31m-    c = stat.isDirectory() ? 'DIR' : 'FILE'[m
[31m-  this.cache[abs] = this.cache[abs] || c[m
[31m-[m
[31m-  if (needDir && c === 'FILE')[m
[31m-    return cb()[m
[31m-[m
[31m-  return cb(null, c, stat)[m
[31m-}[m
[31m-[m
[31m-[m
[31m-/***/ }),[m
[31m-/* 10 */[m
[31m-/***/ (function(module, exports, __webpack_require__) {[m
[31m-[m
[31m-module.exports = realpath[m
[31m-realpath.realpath = realpath[m
[31m-realpath.sync = realpathSync[m
[31m-realpath.realpathSync = realpathSync[m
[31m-realpath.monkeypatch = monkeypatch[m
[31m-realpath.unmonkeypatch = unmonkeypatch[m
[31m-[m
[31m-var fs = __webpack_require__(1)[m
[31m-var origRealpath = fs.realpath[m
[31m-var origRealpathSync = fs.realpathSync[m
[31m-[m
[31m-var version = process.version[m
[31m-var ok = /^v[0-5]\./.test(version)[m
[31m-var old = __webpack_require__(34)[m
[31m-[m
[31m-function newError (er) {[m
[31m-  return er && er.syscall === 'realpath' && ([m
[31m-    er.code === 'ELOOP' ||[m
[31m-    er.code === 'ENOMEM' ||[m
[31m-    er.code === 'ENAMETOOLONG'[m
[31m-  )[m
[31m-}[m
[31m-[m
[31m-function realpath (p, cache, cb) {[m
[31m-  if (ok) {[m
[31m-    return origRealpath(p, cache, cb)[m
[31m-  }[m
[31m-[m
[31m-  if (typeof cache === 'function') {[m
[31m-    cb = cache[m
[31m-    cache = null[m
[31m-  }[m
[31m-  origRealpath(p, cache, function (er, result) {[m
[31m-    if (newError(er)) {[m
[31m-      old.realpath(p, cache, cb)[m
[31m-    } else {[m
[31m-      cb(er, result)[m
[31m-    }[m
[31m-  })[m
[31m-}[m
[31m-[m
[31m-function realpathSync (p, cache) {[m
[31m-  if (ok) {[m
[31m-    return origRealpathSync(p, cache)[m
[31m-  }[m
[31m-[m
[31m-  try {[m
[31m-    return origRealpathSync(p, cache)[m
[31m-  } catch 