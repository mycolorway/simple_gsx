# SimpleGsx

This gem is a Ruby library for communicating with Apple's GSX restful API.

You can visit [this site](https://gsxwsut.apple.com/apidocs/acc/uat/html/WSReference.html?user=reseller&id=1111&lang=EN) to see the full API documents.

## Installation

Add this line to your application's Gemfile:

    gem 'simple_gsx'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_gsx

## Getting Started

In your project, initialize a GSX Client Object:

```
require 'simple_gsx'

config = {
	user_id: 	'YOUR_USER_ID',
	password: 	'YOUR_PASSWORD',
	ship_to: 	'YOUR_SHIP_TO_CODE',
	cert_file:  '/PATH/TO/YOUR/CERT.pem',
	lang_code:  'OPTIONAL, DEFAULT TO "zh"',
	time_zone:  'OPTIONAL, DEFAULT TO "-480"'
}

gsx = SimpleGsx::Client.new(config)

# 360 lookup API request
lookup_params = {
	device_id: 					'YOUR_APPLE_DEVICE_ID',
	purchase_order_number: 		'OPTIONAL',
	customer_email_id: 			'OPTIONAL'
}
device_info = gsx.order_lookup(lookup_params)
```
 
## Other instance methods

###create_order

```
order_params = {
	purchase_order_number: 		'YOUR SYSTEM ORDER NUMBER, MAX TO 13 LENGTH',
	customer_first_name:   		'zheng',
	customer_last_name: 		'xu',
	customer_email: 			'zchar@mycolorway.com',
	customer_address: 			'CUSTOMER ADDRESS',
	customer_mobile_number: 	'CUSTOMER MOBILE NUMBER',
	customer_zip_code: 			'OPTIONAL, CUSTOMER ZIP CODE',
	device_id: 					'APPLE DEVICE ID',
	created_at: 				Time.zone.now
}
gsx.create_order order_params
```

###cancel_order

```
order_params = {
	purchase_order_number: 		'YOUR SYSTEM ORDER NUMBER, MAX TO 13 LENGTH',
	customer_first_name:   		'zheng',
	customer_last_name: 		'xu',
	customer_email: 			'zchar@mycolorway.com',
	customer_address: 			'CUSTOMER ADDRESS',
	customer_mobile_number: 	'CUSTOMER MOBILE NUMBER',
	customer_zip_code: 			'OPTIONAL, CUSTOMER ZIP CODE',
	device_id: 					'APPLE DEVICE ID',
	created_at: 				Time.zone.now
}
gsx.cancel_order order_params
```
###verify_order
```
order_params = {
	purchase_order_number: 		'YOUR SYSTEM ORDER NUMBER, MAX TO 13 LENGTH',
	customer_first_name:   		'zheng',
	customer_last_name: 		'xu',
	customer_email: 			'zchar@mycolorway.com',
	customer_address: 			'CUSTOMER ADDRESS',
	customer_mobile_number: 	'CUSTOMER MOBILE NUMBER',
	customer_zip_code: 			'OPTIONAL, CUSTOMER ZIP CODE',
	device_id: 					'APPLE DEVICE ID',
	created_at: 				Time.zone.now
}
gsx.verify_order order_params
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/simple_gsx/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2008-2014 zchar@mycolorway.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
