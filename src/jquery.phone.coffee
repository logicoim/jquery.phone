$ = window.jQuery or window.$
$.phone = {}
$.phone.fn = {}
$.fn.phone = (method, args...) ->
  if !method? or !(typeof(method) == 'string')
    args = [ method ] if method?
    method = 'init'
  $.phone.fn[method].apply(this, args);

# Utils

defaultPrefix = '+1'

$.phone.countries = countries =
  '+1' :
    code : 'US',
    format : '+. (...) ...-....',
  '+44' :
    code : 'GB',
    format : '+.. .... ......',

do (countries) ->
  # Canada
  canadaPrefixes = [403, 587, 780, 250, 604, 778, 204, 506, 709, 902, 226, 249, 289, 343, 416, 519, 613, 647, 705, 807, 905, 418, 438, 450, 514, 579, 581, 819, 873, 306, 867]
  for prefix in canadaPrefixes
    countries['+1' + prefix] = {
      code: 'CA',
      format: '+. (...) ...-....'
    }

  for prefix, country of countries
    countries[prefix].length = country.format.match(/\./g).length

countryFromPhone = (phone) ->
  if phone.indexOf('+') != 0 and defaultPrefix
    phone = defaultPrefix + phone.replace(/\D/g, '')
  else
    phone = '+' + phone.replace(/\D/g, '');

  bestMatch = null
  precision = 0

  for prefix, country of countries
    if phone.length >= prefix.length && phone.substring(0, prefix.length) == prefix && prefix.length > precision
      bestMatch = {}
      for k, v of country
        bestMatch[k] = v
      bestMatch.prefix = prefix
      precision = prefix.length

  bestMatch

hasTextSelected = ($target) ->
  # If some text is selected
  return true if $target.prop('selectionStart')? and
    $target.prop('selectionStart') isnt $target.prop('selectionEnd')

  # If some text is selected in IE
  if document?.selection?.createRange?
    return true if document.selection.createRange().text

  false

# Private

# Safe Val

safeVal = (value, $target) ->
  try
    cursor = $target.prop('selectionStart')
  catch error
    cursor = null
  last = $target.val()
  $target.val(value)
  if cursor != null && $target.is(":focus")
    cursor = value.length if cursor is last.length

    # This hack looks for scenarios where we are changing an input's value such
    # that "X| " is replaced with " |X" (where "|" is the cursor). In those
    # scenarios, we want " X|".
    #
    # For example:
    # 1. Input field has value "123| "
    # 2. User types "1"
    # 3. Input field has value "123| "
    # 4. Reformatter changes it to "123 |1"
    # 5. By incrementing the cursor, we make it "123 1|"
    #
    # This is awful, and ideally doesn't go here, but given the current design
    # of the system there does not appear to be a better solution.
    #
    # Note that we can't just detect when the cursor-1 is " ", because that
    # would incorrectly increment the cursor when backspacing, e.g. pressing
    # backspace in this scenario: "123 4|567".
    if last != value
      prevPair = last[cursor-1..cursor]
      currPair = value[cursor-1..cursor]
      digit = value[cursor]
      cursor = cursor + 1 if /\d/.test(digit) and
        prevPair == "#{digit} " and currPair == " #{digit}"

    $target.prop('selectionStart', cursor)
    $target.prop('selectionEnd', cursor)
  else
    $target.change()

# Replace Full-Width Chars

replaceFullWidthChars = (str = '') ->
  fullWidth = '\uff10\uff11\uff12\uff13\uff14\uff15\uff16\uff17\uff18\uff19'
  halfWidth = '0123456789'

  value = ''
  chars = str.split('')

  # Avoid using reserved word `char`
  for chr in chars
    idx = fullWidth.indexOf(chr)
    chr = halfWidth[idx] if idx > -1
    value += chr

  value

# Check Prefix Subsets

prefixesAreSubsets = (prefixA, prefixB) ->
  return true if prefixA == prefixB
  if prefixA.length < prefixB.length
    return prefixB.substring(0, prefixA.length) == prefixA
  return prefixA.substring(0, prefixB.length) == prefixB

# Format Phone

reFormatPhone = (e) ->
  $target = $(e.currentTarget)
  setTimeout ->
    value    = $target.val()
    value    = replaceFullWidthChars(value)
    value    = $.phone.formatPhone(value)
    safeVal(value, $target)

formatPhone = (e) ->
  # Only format if input is a number
  digit = String.fromCharCode(e.which)
  return unless /^\d+$/.test(digit)

  $target = $(e.currentTarget)
  value   = $target.val()
  country = countryFromPhone(value + digit)
  length  = (value.replace(/\D/g, '') + digit).length

  upperLength = 11 # 15551234567 is the default length for US/CA
  upperLength = country.length if country
  return false if length >= upperLength

formatBackPhone = (e) ->
  $target = $(e.currentTarget)
  value   = $target.val()

  # Return unless backspacing
  return unless e.which is 8

  # Return if focus isn't at the end of the text
  return if $target.prop('selectionStart')? and
    $target.prop('selectionStart') isnt value.length

  # Remove the remove dash/parentesis, space, and trailing digit
  if /[-)]?\s\d$/.test(value)
    e.preventDefault()
    setTimeout -> $target.val(value.replace(/[-)]?\s\d$/, ''))
  # Remove the space, parentesis and digit
  else if /\s?[(]\d$/.test(value)
    e.preventDefault()
    setTimeout -> $target.val(value.replace(/\s?[(]\d$/, ''))
  # Remove the plus and digit
  else if /[+]\d/.test(value)
    e.preventDefault()
    setTimeout -> $target.val(value.replace(/[+]\d$/, ''))
  # Remove the digit + trailing space
  else if /\d\s$/.test(value)
    e.preventDefault()
    setTimeout -> $target.val(value.replace(/\d\s$/, ''))
  # Remove digit if ends in space + digit
  else if /\s\d?$/.test(value)
    e.preventDefault()
    setTimeout -> $target.val(value.replace(/\d$/, ''))

# Restrictions

restrictNumeric = (e) ->
  # Key event is for a browser shortcut
  return true if e.metaKey or e.ctrlKey

  # If keycode is a space
  return false if e.which is 32

  # If keycode is a special char (WebKit)
  return true if e.which is 0

  # If char is a special char (Firefox)
  return true if e.which < 33

  input = String.fromCharCode(e.which)

  !!/[\d\s+]/.test(input)

restrictPhone = (e) ->
  $target = $(e.currentTarget)
  digit = String.fromCharCode(e.which)
  return unless /^\d+$/.test(digit)

  return if hasTextSelected($target)

  # Restrict number of digits
  value   = ($target.val() + digit).replace(/\D/g, '')
  country = countryFromPhone(value)

  if country
    value.length <= country.length
  else
    # US/CA defaults to 11 digits with country code.
    value.length <= 11

setPhoneCountry = (e) ->
  $target = $(e.currentTarget)
  value   = $target.val()
  country = $.phone.country(value) or 'unknown'

  unless $target.hasClass(country)
    allCountries = (country.code for country in countries)

    $target.removeClass('unknown')
    $target.removeClass(allCountries.join(' '))

    $target.addClass(country)
    $target.toggleClass('identified', country isnt 'unknown')
    $target.trigger('phone.country', country)

# Public

# Initialization

$.phone.fn.init = (options = {}) ->
  @on('keypress', restrictNumeric)
  @on('keypress', restrictPhone)
  @on('keypress', formatPhone)
  @on('keydown', formatBackPhone)
  @on('keyup', setPhoneCountry)
  @on('paste', reFormatPhone)
  @on('change', reFormatPhone)
  @on('input', reFormatPhone)
  @on('input', setPhoneCountry)

  if options.defaultPrefix?
    defaultPrefix = options.defaultPrefix

  if options.value?
    @val(options.value).change()
  else if @val()?
    @change()

  this

# Getters

$.phone.fn.val = () ->
  value = @val().replace(/\D/g, '')
  if @val().indexOf('+') == 0 or !defaultPrefix
    '+' + value
  else
    defaultPrefix + value

$.phone.fn.country = () ->
  value = @phone('val')
  $.phone.country(value)

$.phone.fn.prefix = () ->
  value = @phone('val')
  $.phone.prefix(value)


# Validations

$.phone.fn.validate = () ->
  value   = @phone('val').replace(/\D/g, '')
  country = countryFromPhone(value)
  return false unless country

  return value.length == country.length

# Helpers

$.phone.country = (phone) ->
  return null unless phone
  countryFromPhone(phone)?.code or null

$.phone.prefix = (phone) ->
  return null unless phone
  countryFromPhone(phone)?.prefix or null

$.phone.formatPhone = (phone) ->
  # Return if the phone is empty
  return '' unless phone.length != 0 and (phone.substring(0, 1) == '+' or defaultPrefix)


  country = countryFromPhone(phone)
  return phone unless country

  upperLength = country.length
  phone       = phone.replace(/\D/g, '')[0...upperLength]
  format      = country.format
  prefix      = country.prefix

  if defaultPrefix
    if (prefix == defaultPrefix or prefixesAreSubsets(prefix, defaultPrefix)) and phone.indexOf('+') != 0
      format = format.substring(Math.min(prefix.length, defaultPrefix.length) + 1)
      if country.nationalPrefix?
        prefixFormat = ''
        for i in [0...country.nationalPrefix.length]
          prefixFormat += '.'
        format = prefixFormat + format

  if phone.substring(0, 1) == '+'
    digits = phone.substring(1)
  else
    digits = phone

  digitCount = format.match(/\./g).length

  formatted = ''
  for formatChar in format
    if formatChar == '.'
      if digits.length == 0
        break

      formatted += digits.substring(0, 1)
      digits = digits.substring(1)
    else if digits.length > 0
      formatted += formatChar

  return formatted + digits
