require "simple_gsx/version"
require "rest-client"
require "json"

module SimpleGsx
  class Client
    attr_reader :cert_file, :user_id, :password, :ship_to,
      :cert_file, :lang_code, :time_zone

    API_BASE = 'https://api-acc-ept.apple.com'
    API_VERSION = '1.0'

    AUTH_URL = "#{API_BASE}/authentication-service/#{API_VERSION}/authenticate/"

    CREATE_ORDER_URL = "#{API_BASE}/order-service/#{API_VERSION}/create-order/"
    CANCEL_ORDER_URL = "#{API_BASE}/order-service/#{API_VERSION}/cancel-order/"
    VERIFY_ORDER_URL = "#{API_BASE}/order-service/#{API_VERSION}/verify-order/"
    LOOKUP_URL = "#{API_BASE}/order-service/#{API_VERSION}/get-order/"

    def initialize options
      @user_id = options.fetch :user_id
      @password = options.fetch :password
      @ship_to = options.fetch :ship_to
      @cert_file = options.fetch :cert_file

      # Options
      @lang_code = options[:lang_code] || 'zh'
      @time_zone = options[:time_zone] || '-480'
    end

    #
    # See: https://gsxwsut.apple.com/apidocs/acc/uat/html/WSReference.html?user=reseller
    # Section: Order/CreateOrder
    #
    def create_order options
      body = {
        requestContext: request_context,
        appleCareSalesDate: options[:purchase_date].strftime('%y-%m-%d'),
        pocLanguage: 'ZHS',
        pocDeliveryPreference: 'E',
        purchaseOrderNumber: options[:purchase_order_number],
        MRC: '',
        marketID: '',
        overridePocFlag: '',
        emailFlag: 'Y',
        customerRequest: customer_request(options),
        deviceRequest: [device_request(options)]
      }

      api_request CREATE_ORDER_URL, body
    end

    #
    # See: https://gsxwsut.apple.com/apidocs/acc/uat/html/WSReference.html?user=reseller
    # Section: Order/CancelOrder
    #
    def cancel_order options
      body = {
        deviceId: options[:device_id],
        purchaseOrderNumber: options[:purchase_order_number],
        cancellationDate: options[:cancel_date].strftime('%y-%m-%d'),
        cancelReasonCode: options[:cancel_reason_code] || "",
        requestContext: request_context
      }

      api_request CANCEL_ORDER_URL, body
    end

    #
    # See: https://gsxwsut.apple.com/apidocs/acc/uat/html/WSReference.html?user=reseller
    # Section: Order/VerifyOrder
    #
    def verify_order options
      body = {
        requestContext: request_context,
        appleCareSalesDate: "",
        pocLanguage: "ZHS",
        pocDeliveryPreference: "",
        purchaseOrderNumber: "",
        MRC: "",
        marketID: "",
        overridePocFlag: "",
        emailFlag: "Y",
        customerRequest: customer_request(options),
        deviceRequest: [device_request(options)]
      }

      api_request VERIFY_ORDER_URL, body
    end

    #
    # See: https://gsxwsut.apple.com/apidocs/acc/uat/html/WSReference.html?user=reseller
    # Section: 360 Look Up
    #
    def order_lookup options
      body = {
        requestContext: request_context,
        deviceId: options[:device_id],
        purchaseOrderNumber: options[:purchase_order_number] || "",
        customerEmailId: options[:customer_email_id] || ""
      }

      api_request LOOKUP_URL, body
    end

    private

    def json json_string
      JSON.parse json_string, symbolize_names: true
    end

    def headers
      { accAccessToken: access_token, :'content-type' => 'application/json' }
    end

    def request_context
      { shipTo: ship_to, timeZone: time_zone, langCode: lang_code }
    end

    def customer_request options
      {
        customerFirstName: options[:customer_first_name] || "",
        customerLastName: options[:customer_last_name] || "",
        companyName: "",
        customerEmailId: options[:customer_email],
        addressLine1: options[:customer_address],
        addressLine2: "",
        city: "",
        stateCode: "230",
        countryCode: "CN",
        primaryPhoneNumber: options[:customer_mobile_number],
        zipCode: options[:customer_zip_code]
      }
    end

    def device_request options
      {
        deviceId: options[:device_id],
        secondarySerialNumber: options[:secondary_device_id] || "",
        hardwareDateOfPurchase: options[:date_of_purchase] || "" #"09/11/13"
      }
    end

    def access_token
      @access_token ||= begin
                          body = {
                            userId: user_id,
                            password: password,
                            shipTo: ship_to,
                            langCode: lang_code,
                            timeZone: time_zone
                          }

                          response = api_request AUTH_URL, body
                          response[:accessToken]
                        end
    end

    def api_request url, body
      response = RestClient::Resource.new(
        url,
        :ssl_client_cert  =>  OpenSSL::X509::Certificate.new(File.read(cert_file)),
        :ssl_client_key   =>  OpenSSL::PKey::RSA.new(File.read(cert_file), ''),
        :ssl_ca_file      =>  cert_file,
        :verify_ssl       =>  false
      ).post JSON.dump(body), headers

      json response
    end
  end
end
