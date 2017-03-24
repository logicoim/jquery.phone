/*! jquery.phone v1.0.4 | Copyright 2017 Andrew Ellis (awellis89@gmail.com) | MIT */

(function() {
  var $, countries, countryFromPhone, defaultPrefix, formatBackPhone, formatPhone, hasTextSelected, prefixesAreSubsets, reFormatPhone, replaceFullWidthChars, restrictNumeric, restrictPhone, safeVal, setPhoneCountry,
    slice = [].slice;

  $ = window.jQuery || window.$;

  $.phone = {};

  $.phone.fn = {};

  $.fn.phone = function() {
    var args, method;
    method = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];
    if ((method == null) || !(typeof method === 'string')) {
      if (method != null) {
        args = [method];
      }
      method = 'init';
    }
    return $.phone.fn[method].apply(this, args);
  };

  defaultPrefix = '+1';

  $.phone.countries = countries = {
    '+1': {
      code: 'US',
      format: '+. (...) ...-....'
    },
    '+44': {
      code: 'GB',
      format: '+.. .... ......'
    }
  };

  (function(countries) {
    var canadaPrefixes, country, j, len, prefix, results;
    canadaPrefixes = [403, 587, 780, 250, 604, 778, 204, 506, 709, 902, 226, 249, 289, 343, 416, 519, 613, 647, 705, 807, 905, 418, 438, 450, 514, 579, 581, 819, 873, 306, 867];
    for (j = 0, len = canadaPrefixes.length; j < len; j++) {
      prefix = canadaPrefixes[j];
      countries['+1' + prefix] = {
        code: 'CA',
        format: '+. (...) ...-....'
      };
    }
    results = [];
    for (prefix in countries) {
      country = countries[prefix];
      results.push(countries[prefix].length = country.format.match(/\./g).length);
    }
    return results;
  })(countries);

  countryFromPhone = function(phone) {
    var bestMatch, country, k, precision, prefix, v;
    if (phone.indexOf('+') !== 0 && defaultPrefix) {
      phone = defaultPrefix + phone.replace(/\D/g, '');
    } else {
      phone = '+' + phone.replace(/\D/g, '');
    }
    bestMatch = null;
    precision = 0;
    for (prefix in countries) {
      country = countries[prefix];
      if (phone.length >= prefix.length && phone.substring(0, prefix.length) === prefix && prefix.length > precision) {
        bestMatch = {};
        for (k in country) {
          v = country[k];
          bestMatch[k] = v;
        }
        bestMatch.prefix = prefix;
        precision = prefix.length;
      }
    }
    return bestMatch;
  };

  hasTextSelected = function($target) {
    var ref;
    if (($target.prop('selectionStart') != null) && $target.prop('selectionStart') !== $target.prop('selectionEnd')) {
      return true;
    }
    if ((typeof document !== "undefined" && document !== null ? (ref = document.selection) != null ? ref.createRange : void 0 : void 0) != null) {
      if (document.selection.createRange().text) {
        return true;
      }
    }
    return false;
  };

  safeVal = function(value, $target) {
    var currPair, cursor, digit, error, error1, last, prevPair;
    try {
      cursor = $target.prop('selectionStart');
    } catch (error1) {
      error = error1;
      cursor = null;
    }
    last = $target.val();
    $target.val(value);
    if (cursor !== null && $target.is(":focus")) {
      if (cursor === last.length) {
        cursor = value.length;
      }
      if (last !== value) {
        prevPair = last.slice(cursor - 1, +cursor + 1 || 9e9);
        currPair = value.slice(cursor - 1, +cursor + 1 || 9e9);
        digit = value[cursor];
        if (/\d/.test(digit) && prevPair === (digit + " ") && currPair === (" " + digit)) {
          cursor = cursor + 1;
        }
      }
      $target.prop('selectionStart', cursor);
      return $target.prop('selectionEnd', cursor);
    }
  };

  replaceFullWidthChars = function(str) {
    var chars, chr, fullWidth, halfWidth, idx, j, len, value;
    if (str == null) {
      str = '';
    }
    fullWidth = '\uff10\uff11\uff12\uff13\uff14\uff15\uff16\uff17\uff18\uff19';
    halfWidth = '0123456789';
    value = '';
    chars = str.split('');
    for (j = 0, len = chars.length; j < len; j++) {
      chr = chars[j];
      idx = fullWidth.indexOf(chr);
      if (idx > -1) {
        chr = halfWidth[idx];
      }
      value += chr;
    }
    return value;
  };

  prefixesAreSubsets = function(prefixA, prefixB) {
    if (prefixA === prefixB) {
      return true;
    }
    if (prefixA.length < prefixB.length) {
      return prefixB.substring(0, prefixA.length) === prefixA;
    }
    return prefixA.substring(0, prefixB.length) === prefixB;
  };

  reFormatPhone = function(e) {
    var $target;
    $target = $(e.currentTarget);
    return setTimeout(function() {
      var value;
      value = $target.val();
      value = replaceFullWidthChars(value);
      value = $.phone.formatPhone(value);
      return safeVal(value, $target);
    });
  };

  formatPhone = function(e) {
    var $target, country, digit, length, upperLength, value;
    digit = String.fromCharCode(e.which);
    if (!/^\d+$/.test(digit)) {
      return;
    }
    $target = $(e.currentTarget);
    value = $target.val();
    country = countryFromPhone(value + digit);
    length = (value.replace(/\D/g, '') + digit).length;
    upperLength = 11;
    if (country) {
      upperLength = country.length;
    }
    if (length >= upperLength) {
      return false;
    }
  };

  formatBackPhone = function(e) {
    var $target, value;
    $target = $(e.currentTarget);
    value = $target.val();
    if (e.which !== 8) {
      return;
    }
    if (($target.prop('selectionStart') != null) && $target.prop('selectionStart') !== value.length) {
      return;
    }
    if (/[-)]?\s\d$/.test(value)) {
      e.preventDefault();
      return setTimeout(function() {
        return $target.val(value.replace(/[-)]?\s\d$/, ''));
      });
    } else if (/\s?[(]\d$/.test(value)) {
      e.preventDefault();
      return setTimeout(function() {
        return $target.val(value.replace(/\s?[(]\d$/, ''));
      });
    } else if (/[+]\d/.test(value)) {
      e.preventDefault();
      return setTimeout(function() {
        return $target.val(value.replace(/[+]\d$/, ''));
      });
    } else if (/\d\s$/.test(value)) {
      e.preventDefault();
      return setTimeout(function() {
        return $target.val(value.replace(/\d\s$/, ''));
      });
    } else if (/\s\d?$/.test(value)) {
      e.preventDefault();
      return setTimeout(function() {
        return $target.val(value.replace(/\d$/, ''));
      });
    }
  };

  restrictNumeric = function(e) {
    var input;
    if (e.metaKey || e.ctrlKey) {
      return true;
    }
    if (e.which === 32) {
      return false;
    }
    if (e.which === 0) {
      return true;
    }
    if (e.which < 33) {
      return true;
    }
    input = String.fromCharCode(e.which);
    return !!/[\d\s+]/.test(input);
  };

  restrictPhone = function(e) {
    var $target, country, digit, value;
    $target = $(e.currentTarget);
    digit = String.fromCharCode(e.which);
    if (!/^\d+$/.test(digit)) {
      return;
    }
    if (hasTextSelected($target)) {
      return;
    }
    value = ($target.val() + digit).replace(/\D/g, '');
    country = countryFromPhone(value);
    if (country) {
      return value.length <= country.length;
    } else {
      return value.length <= 11;
    }
  };

  setPhoneCountry = function(e) {
    var $target, allCountries, country, value;
    $target = $(e.currentTarget);
    value = $target.val();
    country = $.phone.country(value) || 'unknown';
    if (!$target.hasClass(country)) {
      allCountries = (function() {
        var j, len, results;
        results = [];
        for (j = 0, len = countries.length; j < len; j++) {
          country = countries[j];
          results.push(country.code);
        }
        return results;
      })();
      $target.removeClass('unknown');
      $target.removeClass(allCountries.join(' '));
      $target.addClass(country);
      $target.toggleClass('identified', country !== 'unknown');
      return $target.trigger('phone.country', country);
    }
  };

  $.phone.fn.init = function(options) {
    if (options == null) {
      options = {};
    }
    this.on('keypress', restrictNumeric);
    this.on('keypress', restrictPhone);
    this.on('keypress', formatPhone);
    this.on('keydown', formatBackPhone);
    this.on('keyup', setPhoneCountry);
    this.on('paste', reFormatPhone);
    this.on('change', reFormatPhone);
    this.on('input', reFormatPhone);
    this.on('input', setPhoneCountry);
    if (options.defaultPrefix != null) {
      defaultPrefix = options.defaultPrefix;
    }
    if (options.value != null) {
      this.val(options.value).change();
    } else if (this.val() != null) {
      this.change();
    }
    return this;
  };

  $.phone.fn.val = function() {
    var value;
    value = this.val();
    if (!value) {
      return '';
    }
    value = value.replace(/\D/g, '');
    if (this.val().indexOf('+') === 0 || !defaultPrefix) {
      return '+' + value;
    } else {
      return defaultPrefix + value;
    }
  };

  $.phone.fn.country = function() {
    var value;
    value = this.phone('val');
    return $.phone.country(value);
  };

  $.phone.fn.prefix = function() {
    var value;
    value = this.phone('val');
    return $.phone.prefix(value);
  };

  $.phone.fn.validate = function() {
    var country, value;
    value = this.phone('val').replace(/\D/g, '');
    country = countryFromPhone(value);
    if (!country) {
      return false;
    }
    return value.length === country.length;
  };

  $.phone.country = function(phone) {
    var ref;
    if (!phone) {
      return null;
    }
    return ((ref = countryFromPhone(phone)) != null ? ref.code : void 0) || null;
  };

  $.phone.prefix = function(phone) {
    var ref;
    if (!phone) {
      return null;
    }
    return ((ref = countryFromPhone(phone)) != null ? ref.prefix : void 0) || null;
  };

  $.phone.formatPhone = function(phone) {
    var country, digitCount, digits, format, formatChar, formatted, i, j, l, len, prefix, prefixFormat, ref, upperLength;
    if (!(phone.length !== 0 && (phone.substring(0, 1) === '+' || defaultPrefix))) {
      return '';
    }
    country = countryFromPhone(phone);
    if (!country) {
      return phone;
    }
    upperLength = country.length;
    phone = phone.replace(/\D/g, '').slice(0, upperLength);
    format = country.format;
    prefix = country.prefix;
    if (defaultPrefix) {
      if ((prefix === defaultPrefix || prefixesAreSubsets(prefix, defaultPrefix)) && phone.indexOf('+') !== 0) {
        format = format.substring(Math.min(prefix.length, defaultPrefix.length) + 1);
        if (country.nationalPrefix != null) {
          prefixFormat = '';
          for (i = j = 0, ref = country.nationalPrefix.length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
            prefixFormat += '.';
          }
          format = prefixFormat + format;
        }
      }
    }
    if (phone.substring(0, 1) === '+') {
      digits = phone.substring(1);
    } else {
      digits = phone;
    }
    digitCount = format.match(/\./g).length;
    formatted = '';
    for (l = 0, len = format.length; l < len; l++) {
      formatChar = format[l];
      if (formatChar === '.') {
        if (digits.length === 0) {
          break;
        }
        formatted += digits.substring(0, 1);
        digits = digits.substring(1);
      } else if (digits.length > 0) {
        formatted += formatChar;
      }
    }
    return formatted + digits;
  };

}).call(this);
