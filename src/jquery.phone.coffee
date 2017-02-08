$ = window.jQuery or window.$
$.phone = {}
$.phone.fn = {}
$.fn.phone = (method, args...) ->
  if !method? or !(typeof(method) == 'string')
    method = 'init'
  $.phone.fn[method].apply(this, args);

# Utils

$.phone.formats = formats =
  '+247' :
    country : 'AC',
  '+376' :
    country : 'AD',
    format : '+... ... ...',
  '+971' :
    country : 'AE',
    format : '+... .. ... ....',
  '+93' :
    country : 'AF',
    format : '+.. .. ... ....',
  '+1268' :
    country : 'AG',
  '+1264' :
    country : 'AI',
  '+355' :
    country : 'AL',
    format : '+... .. ... ....',
  '+374' :
    country : 'AM',
    format : '+... .. ......',
  '+244' :
    country : 'AO',
    format : '+... ... ... ...',
  '+54' :
    country : 'AR',
    format : '+.. .. ..-....-....',
  '+1684' :
    country : 'AS',
  '+43' :
    country : 'AT',
    format : '+.. ... ......',
  '+61' :
    country : 'AU',
    format : '+.. ... ... ...',
  '+297' :
    country : 'AW',
    format : '+... ... ....',
  '+994' :
    country : 'AZ',
    format : '+... .. ... .. ..',
  '+387' :
    country : 'BA',
    format : '+... .. ...-...',
  '+1246' :
    country : 'BB',
  '+880' :
    country : 'BD',
    format : '+... ....-......',
  '+32' :
    country : 'BE',
    format : '+.. ... .. .. ..',
  '+226' :
    country : 'BF',
    format : '+... .. .. .. ..',
  '+359' :
    country : 'BG',
    format : '+... ... ... ..',
  '+973' :
    country : 'BH',
    format : '+... .... ....',
  '+257' :
    country : 'BI',
    format : '+... .. .. .. ..',
  '+229' :
    country : 'BJ',
    format : '+... .. .. .. ..',
  '+1441' :
    country : 'BM',
  '+673' :
    country : 'BN',
    format : '+... ... ....',
  '+591' :
    country : 'BO',
    format : '+... ........',
  '+55' :
    country : 'BR',
    format : '+.. .. .....-....',
  '+1242' :
    country : 'BS',
  '+975' :
    country : 'BT',
    format : '+... .. .. .. ..',
  '+267' :
    country : 'BW',
    format : '+... .. ... ...',
  '+375' :
    country : 'BY',
    format : '+... .. ...-..-..',
  '+501' :
    country : 'BZ',
    format : '+... ...-....',
  '+243' :
    country : 'CD',
    format : '+... ... ... ...',
  '+236' :
    country : 'CF',
    format : '+... .. .. .. ..',
  '+242' :
    country : 'CG',
    format : '+... .. ... ....',
  '+41' :
    country : 'CH',
    format : '+.. .. ... .. ..',
  '+225' :
    country : 'CI',
    format : '+... .. .. .. ..',
  '+682' :
    country : 'CK',
    format : '+... .. ...',
  '+56' :
    country : 'CL',
    format : '+.. . .... ....',
  '+237' :
    country : 'CM',
    format : '+... .. .. .. ..',
  '+86' :
    country : 'CN',
    format : '+.. ... .... ....',
  '+57' :
    country : 'CO',
    format : '+.. ... .......',
  '+506' :
    country : 'CR',
    format : '+... .... ....',
  '+53' :
    country : 'CU',
    format : '+.. . .......',
  '+238' :
    country : 'CV',
    format : '+... ... .. ..',
  '+599' :
    country : 'CW',
    format : '+... . ... ....',
  '+537' :
    country : 'CY',
  '+357' :
    country : 'CY',
    format : '+... .. ......',
  '+420' :
    country : 'CZ',
    format : '+... ... ... ...',
  '+49' :
    country : 'DE',
    format : '+.. .... .......',
  '+253' :
    country : 'DJ',
    format : '+... .. .. .. ..',
  '+45' :
    country : 'DK',
    format : '+.. .. .. .. ..',
  '+1767' :
    country : 'DM',
  '+1849' :
    country : 'DO',
  '+213' :
    country : 'DZ',
    format : '+... ... .. .. ..',
  '+593' :
    country : 'EC',
    format : '+... .. ... ....',
  '+372' :
    country : 'EE',
    format : '+... .... ....',
  '+20' :
    country : 'EG',
    format : '+.. ... ... ....',
  '+291' :
    country : 'ER',
    format : '+... . ... ...',
  '+34' :
    country : 'ES',
    format : '+.. ... .. .. ..',
  '+251' :
    country : 'ET',
    format : '+... .. ... ....',
  '+358' :
    country : 'FI',
    format : '+... .. ... .. ..',
  '+679' :
    country : 'FJ',
    format : '+... ... ....',
  '+500' :
    country : 'FK',
  '+691' :
    country : 'FM',
    format : '+... ... ....',
  '+298' :
    country : 'FO',
    format : '+... ......',
  '+33' :
    country : 'FR',
    format : '+.. . .. .. .. ..',
  '+241' :
    country : 'GA',
    format : '+... .. .. .. ..',
  '+44' :
    country : 'GB',
    format : '+.. .... ......',
  '+1473' :
    country : 'GD',
  '+995' :
    country : 'GE',
    format : '+... ... .. .. ..',
  '+594' :
    country : 'GF',
    format : '+... ... .. .. ..',
  '+233' :
    country : 'GH',
    format : '+... .. ... ....',
  '+350' :
    country : 'GI',
    format : '+... ... .....',
  '+299' :
    country : 'GL',
    format : '+... .. .. ..',
  '+220' :
    country : 'GM',
    format : '+... ... ....',
  '+224' :
    country : 'GN',
    format : '+... ... .. .. ..',
  '+240' :
    country : 'GQ',
    format : '+... ... ... ...',
  '+30' :
    country : 'GR',
    format : '+.. ... ... ....',
  '+502' :
    country : 'GT',
    format : '+... .... ....',
  '+1671' :
    country : 'GU',
  '+245' :
    country : 'GW',
    format : '+... ... ....',
  '+592' :
    country : 'GY',
    format : '+... ... ....',
  '+852' :
    country : 'HK',
    format : '+... .... ....',
  '+504' :
    country : 'HN',
    format : '+... ....-....',
  '+385' :
    country : 'HR',
    format : '+... .. ... ....',
  '+509' :
    country : 'HT',
    format : '+... .. .. ....',
  '+36' :
    country : 'HU',
    format : '+.. .. ... ....',
  '+62' :
    country : 'ID',
    format : '+.. ...-...-...',
  '+353' :
    country : 'IE',
    format : '+... .. ... ....',
  '+972' :
    country : 'IL',
    format : '+... ..-...-....',
  '+91' :
    country : 'IN',
    format : '+.. .. .. ......',
  '+246' :
    country : 'IO',
    format : '+... ... ....',
  '+964' :
    country : 'IQ',
    format : '+... ... ... ....',
  '+98' :
    country : 'IR',
    format : '+.. ... ... ....',
  '+354' :
    country : 'IS',
    format : '+... ... ....',
  '+39' :
    country : 'IT',
    format : '+.. .. .... ....',
  '+1876' :
    country : 'JM',
  '+962' :
    country : 'JO',
    format : '+... . .... ....',
  '+81' :
    country : 'JP',
    format : '+.. ..-....-....',
    nationalPrefix: '0',
  '+254' :
    country : 'KE',
    format : '+... .. .......',
  '+996' :
    country : 'KG',
    format : '+... ... ... ...',
  '+855' :
    country : 'KH',
    format : '+... .. ... ...',
  '+686' :
    country : 'KI',
  '+269' :
    country : 'KM',
    format : '+... ... .. ..',
  '+1869' :
    country : 'KN',
  '+850' :
    country : 'KP',
    format : '+... ... ... ....',
  '+82' :
    country : 'KR',
    format : '+.. ..-....-....',
  '+965' :
    country : 'KW',
    format : '+... ... .....',
  '+345' :
    country : 'KY',
  '+77' :
    country : 'KZ',
  '+856' :
    country : 'LA',
    format : '+... .. .. ... ...',
  '+961' :
    country : 'LB',
    format : '+... .. ... ...',
  '+1758' :
    country : 'LC',
  '+423' :
    country : 'LI',
    format : '+... ... ... ...',
  '+94' :
    country : 'LK',
    format : '+.. .. . ......',
  '+231' :
    country : 'LR',
    format : '+... ... ... ...',
  '+266' :
    country : 'LS',
    format : '+... .... ....',
  '+370' :
    country : 'LT',
    format : '+... ... .....',
  '+352' :
    country : 'LU',
    format : '+... .. .. .. ...',
  '+371' :
    country : 'LV',
    format : '+... .. ... ...',
  '+218' :
    country : 'LY',
    format : '+... ..-.......',
  '+212' :
    country : 'MA',
    format : '+... ...-......',
  '+377' :
    country : 'MC',
    format : '+... . .. .. .. ..',
  '+373' :
    country : 'MD',
    format : '+... ... .. ...',
  '+382' :
    country : 'ME',
    format : '+... .. ... ...',
  '+590' :
    country : 'MF',
  '+261' :
    country : 'MG',
    format : '+... .. .. ... ..',
  '+692' :
    country : 'MH',
    format : '+... ...-....',
  '+389' :
    country : 'MK',
    format : '+... .. ... ...',
  '+223' :
    country : 'ML',
    format : '+... .. .. .. ..',
  '+95' :
    country : 'MM',
    format : '+.. . ... ....',
  '+976' :
    country : 'MN',
    format : '+... .... ....',
  '+853' :
    country : 'MO',
    format : '+... .... ....',
  '+1670' :
    country : 'MP',
  '+596' :
    country : 'MQ',
    format : '+... ... .. .. ..',
  '+222' :
    country : 'MR',
    format : '+... .. .. .. ..',
  '+1664' :
    country : 'MS',
  '+356' :
    country : 'MT',
    format : '+... .... ....',
  '+230' :
    country : 'MU',
    format : '+... .... ....',
  '+960' :
    country : 'MV',
    format : '+... ...-....',
  '+265' :
    country : 'MW',
    format : '+... ... .. .. ..',
  '+52' :
    country : 'MX',
    format : '+.. ... ... ... ....',
  '+60' :
    country : 'MY',
    format : '+.. ..-... ....',
  '+258' :
    country : 'MZ',
    format : '+... .. ... ....',
  '+264' :
    country : 'NA',
    format : '+... .. ... ....',
  '+687' :
    country : 'NC',
    format : '+... ........',
  '+227' :
    country : 'NE',
    format : '+... .. .. .. ..',
  '+672' :
    country : 'NF',
    format : '+... .. ....',
  '+234' :
    country : 'NG',
    format : '+... ... ... ....',
  '+505' :
    country : 'NI',
    format : '+... .... ....',
  '+31' :
    country : 'NL',
    format : '+.. . ........',
  '+47' :
    country : 'NO',
    format : '+.. ... .. ...',
  '+977' :
    country : 'NP',
    format : '+... ...-.......',
  '+674' :
    country : 'NR',
    format : '+... ... ....',
  '+683' :
    country : 'NU',
  '+64' :
    country : 'NZ',
    format : '+.. .. ... ....',
  '+968' :
    country : 'OM',
    format : '+... .... ....',
  '+507' :
    country : 'PA',
    format : '+... ....-....',
  '+51' :
    country : 'PE',
    format : '+.. ... ... ...',
  '+689' :
    country : 'PF',
    format : '+... .. .. ..',
  '+675' :
    country : 'PG',
    format : '+... ... ....',
  '+63' :
    country : 'PH',
    format : '+.. .... ......',
  '+92' :
    country : 'PK',
    format : '+.. ... .......',
  '+48' :
    country : 'PL',
    format : '+.. .. ... .. ..',
  '+508' :
    country : 'PM',
    format : '+... .. .. ..',
  '+872' :
    country : 'PN',
  '+1939' :
    country : 'PR',
  '+970' :
    country : 'PS',
    format : '+... ... ... ...',
  '+351' :
    country : 'PT',
    format : '+... ... ... ...',
  '+680' :
    country : 'PW',
    format : '+... ... ....',
  '+595' :
    country : 'PY',
    format : '+... .. .......',
  '+974' :
    country : 'QA',
    format : '+... .... ....',
  '+262' :
    country : 'RE',
  '+40' :
    country : 'RO',
    format : '+.. .. ... ....',
  '+381' :
    country : 'RS',
    format : '+... .. .......',
  '+7' :
    country : 'RU',
    format : '+. ... ...-..-..',
  '+250' :
    country : 'RW',
    format : '+... ... ... ...',
  '+966' :
    country : 'SA',
    format : '+... .. ... ....',
  '+677' :
    country : 'SB',
    format : '+... ... ....',
  '+248' :
    country : 'SC',
    format : '+... . ... ...',
  '+249' :
    country : 'SD',
    format : '+... .. ... ....',
  '+46' :
    country : 'SE',
    format : '+.. ..-... .. ..',
  '+65' :
    country : 'SG',
    format : '+.. .... ....',
  '+290' :
    country : 'SH',
  '+386' :
    country : 'SI',
    format : '+... .. ... ...',
  '+421' :
    country : 'SK',
    format : '+... ... ... ...',
  '+232' :
    country : 'SL',
    format : '+... .. ......',
  '+378' :
    country : 'SM',
    format : '+... .. .. .. ..',
  '+221' :
    country : 'SN',
    format : '+... .. ... .. ..',
  '+252' :
    country : 'SO',
    format : '+... .. .......',
  '+597' :
    country : 'SR',
    format : '+... ...-....',
  '+211' :
    country : 'SS',
    format : '+... ... ... ...',
  '+239' :
    country : 'ST',
    format : '+... ... ....',
  '+503' :
    country : 'SV',
    format : '+... .... ....',
  '+963' :
    country : 'SY',
    format : '+... ... ... ...',
  '+268' :
    country : 'SZ',
    format : '+... .... ....',
  '+1649' :
    country : 'TC',
  '+235' :
    country : 'TD',
    format : '+... .. .. .. ..',
  '+228' :
    country : 'TG',
    format : '+... .. .. .. ..',
  '+66' :
    country : 'TH',
    format : '+.. .. ... ....',
  '+992' :
    country : 'TJ',
    format : '+... ... .. ....',
  '+690' :
    country : 'TK',
  '+670' :
    country : 'TL',
    format : '+... .... ....',
  '+993' :
    country : 'TM',
    format : '+... .. ..-..-..',
  '+216' :
    country : 'TN',
    format : '+... .. ... ...',
  '+676' :
    country : 'TO',
    format : '+... ... ....',
  '+90' :
    country : 'TR',
    format : '+.. ... ... ....',
  '+1868' :
    country : 'TT',
  '+688' :
    country : 'TV',
  '+886' :
    country : 'TW',
    format : '+... ... ... ...',
  '+255' :
    country : 'TZ',
    format : '+... ... ... ...',
  '+380' :
    country : 'UA',
    format : '+... .. ... ....',
  '+256' :
    country : 'UG',
    format : '+... ... ......',
  '+1' :
    country : 'US',
  '+598' :
    country : 'UY',
    format : '+... .... ....',
  '+998' :
    country : 'UZ',
    format : '+... .. ... .. ..',
  '+379' :
    country : 'VA',
  '+1784' :
    country : 'VC',
  '+58' :
    country : 'VE',
    format : '+.. ...-.......',
  '+1284' :
    country : 'VG',
  '+1340' :
    country : 'VI',
  '+84' :
    country : 'VN',
    format : '+.. .. ... .. ..',
  '+678' :
    country : 'VU',
    format : '+... ... ....',
  '+681' :
    country : 'WF',
    format : '+... .. .. ..',
  '+685' :
    country : 'WS',
  '+967' :
    country : 'YE',
    format : '+... ... ... ...',
  '+27' :
    country : 'ZA',
    format : '+.. .. ... ....',
  '+260' :
    country : 'ZM',
    format : '+... .. .......',
  '+263' :
    country : 'ZW',
    format : '+... .. ... ....',

do (formats) ->
  # Canada
  canadaPrefixes = [403, 587, 780, 250, 604, 778, 204, 506, 709, 902, 226, 249, 289, 343, 416, 519, 613, 647, 705, 807, 905, 418, 438, 450, 514, 579, 581, 819, 873, 306, 867]
  for prefix in canadaPrefixes
    formats['+1' + prefix] = { country: 'CA' }

  for prefix, format of formats
    if prefix.substring(0, 2) == "+1"
      format.format = '+. (...) ...-....'

formatFromPhone = (phone) ->
  phone     = '+' + phone.replace(/\D/g, '');
  bestMatch = null
  precision = 0

  for prefix, format of formats
    if phone.length >= prefix.length && phone.substring(0, prefix.length) == prefix && prefix.length > precision
      bestMatch = {}
      for k, v of format
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
    # 1. Input field has value "4444| "
    # 2. User types "1"
    # 3. Input field has value "44441| "
    # 4. Reformatter changes it to "4444 |1"
    # 5. By incrementing the cursor, we make it "4444 1|"
    #
    # This is awful, and ideally doesn't go here, but given the current design
    # of the system there does not appear to be a better solution.
    #
    # Note that we can't just detect when the cursor-1 is " ", because that
    # would incorrectly increment the cursor when backspacing, e.g. pressing
    # backspace in this scenario: "4444 1|234 5".
    if last != value
      prevPair = last[cursor-1..cursor]
      currPair = value[cursor-1..cursor]
      digit = value[cursor]
      cursor = cursor + 1 if /\d/.test(digit) and
        prevPair == "#{digit} " and currPair == " #{digit}"

    $target.prop('selectionStart', cursor)
    $target.prop('selectionEnd', cursor)

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

# Format Phone

reFormatPhone = (e) ->
  $target = $(e.currentTarget)
  setTimeout ->
    value = $target.val()
    value = replaceFullWidthChars(value)
    value = $.phone.formatPhone(value)
    safeVal(value, $target)

formatPhone = (e) ->
  # Only format if input is a number
  digit = String.fromCharCode(e.which)
  return unless /^\d+$/.test(digit)

  $target = $(e.currentTarget)
  value   = $target.val()
  format  = formatFromPhone(value + digit)
  length  = (value.replace(/\D/g, '') + digit).length

formattedPhone = (phone, lastChar) ->
  if phone.length != 0 and phone.substring(0, 1) == '+'
    format = formatFromPhone(phone)
    if format && format.format
      phoneFormat = format.format
      phonePrefix = format.prefix

      if phone.substring(0, 1) == '+'
        phoneDigits = phone.substring(1)
      else
        phoneDigits = phone

      formatDigitCount = phoneFormat.match(/\./g).length

      formattedPhone = ''
      for formatChar in phoneFormat
        if formatChar == '.'
          if phoneDigits.length == 0
            break

          formattedPhone += phoneDigits.substring(0, 1)
          phoneDigits = phoneDigits.substring(1)
        else if lastChar || phoneDigits.length > 0
          formattedPhone += formatChar

      phone = formattedPhone + phoneDigits

  phone

formatForwardPhone = (e) ->
  digit = String.fromCharCode(e.which)
  return unless /^\d+$/.test(digit)

  checkForCountryChange(e)

  $target = $(e.currentTarget)
  value   = $target.val()

  $target.val(formattedPhone(value, true))

formatBackPhone = (e) ->
  # Return unless backspacing
  return unless e.which is 8
  
  $target = $(e.currentTarget)
  value   = $target.val()

  # Return if focus isn't at the end of the text
  return if $target.prop('selectionStart')? and
    $target.prop('selectionStart') isnt value.length

  # Remove the trailing character.
  value = value.substring(0, value.length - 1)
  e.preventDefault();
  $target.val(formattedPhone(value))

# Check for Country Change
checkForCountryChange = (e) ->
  $target = $(e.currentTarget)
  value   = $target.val()
  format  = formatFromPhone(value)
  country = null
  country = format.country if format
  if $target.data('country') != country
    $target.data('country', country)
    $target.trigger('country.phone', country)

# Restrict Input

restrictNumeric = (e) ->
  # Key event is for a browser shortcut
  return true if e.metaKey or e.ctrlKey

  # If keycode is a space
  return false if e.which is 32

  # If keycode is a special char (WebKit)
  return true if e.which is 0

  # If char is a special char (Firefox)
  return true if e.which < 33

  input = String.fromCharCode(e)

  !!/[\d\s+]/.test(input)

# Public

# Formatting

$.phone.fn.init = ->
  @on('keypress', restrictNumeric)
  @on('keypress', formatPhone)
  @on('keypress', formatForwardPhone)
  @on('keydown', formatBackPhone)
  @on('paste', reFormatPhone)
  @on('change', reFormatPhone)
  @on('input', reFormatPhone)
  $.phone.formatPhone($(this).val())
  this

$.phone.fn.formatPhone = ->
  $.phone.formatPhone($(this).val())

$.phone.formatPhone = (value) ->
  format = formatFromPhone(value)
  return value unless format

  formattedPhone(value)
