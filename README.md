# jQuery.phone [![Build Status](https://travis-ci.org/ellisio/jquery.phone.svg?branch=master)](https://travis-ci.org/ellisio/jquery.phone)

A general purpose library for validating and formatting phone numbers.

``` javascript
$('input.phone-num').phone();
```

You can bind to an event when the user changes the country of the phone number:

``` javascript
$('input.phone-num').bind('country.phone', function(e, country) {
  console.log('The new country code:', country);
})
```

Dependencies:

* Tested on jQuery 3.1.x

## API

### $.fn.phone()

Enables phone number formatting.

### $.fn.phone('val')

Returns the phone number value with prefix, but without other formatting.

Example:

``` javascript
$('input.phone-num').val(); //=> '+1 (415) 123-5554'
$('input.phone-num').phone('val'); //=> '+14151235554'
```

### $.fn.phone('validate')

Returns whether the phone number is valid.

*Note:* this implementation is very naive; it only validates that the phone number is longer than its prefix.

Example:

``` javascript
$('input.phone-num').val(); //=> '+1 (415) 123-5554'
$('input.phone-num').phone('validate'); //=> true

$('input.phone-num').val(); //=> '+43'
$('input.phone-num').phone('validate'); //=> false
```

### $.fn.phone('country')

Returns the two-letter country code of the phone number.

Example:

``` javascript
$('input.phone-num').val(); //=> '+32 495 12 34 56'
$('input.phone-num').phone('country'); //=> 'BE'
```

### $.fn.phone('prefix')

Returns the prefix of the phone number.

Example:

``` javascript
$('input.phone-num').val(); //=> '+32 495 12 34 56'
$('input.phone-num').phone('prefix'); //=> '+32'
```

### $.formatPhone(phone)

Returns the formatted phone number.

Example:

``` javascript
$.phone.formatPhone('14151235554'); //=> '+1 (415) 123-5554'
```

## Events

### country.phone

Triggered when the country has changed.

Example:

``` javascript
$('input.phone-num').bind('phone.country', function(e, country) {
  console.log('The new country code:', country);
})

// Simulate user input
$('input.phone-num').val('+32495123456').keyup();
//=> The new country code: BE
```

## Building

Run `grunt`

## Mobile recommendations

We recommend you set the `pattern`, `type`, and `x-autocompletetype` attributes, which will trigger autocompletion and a numeric keypad to display on touch devices:

``` html
<input class="phone-num" type="tel" pattern="\d*" x-autocompletetype="tel">
```

You may have to turn off HTML5 validation (using the `novalidate` form attribute) when using this `pattern`, since it won't permit spaces and other characters that appear in the formatted version of the phone number.
