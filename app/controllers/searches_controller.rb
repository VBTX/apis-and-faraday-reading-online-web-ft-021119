class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'AFQD2E1PJMJ3YYHQNLA4GY35IY52WWLEDSAIIAWLJJX41QGM'
      req.params['client_secret'] = '0KGXVWG1040IFTO5QCJOPMNDJKI3WDHT2QKXG5SU5TBTKDK2'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
   body = JSON.parse(@resp.body)
  if @resp.success?
    @venues = body["response"]["venues"]
  else
    @error = body["meta"]["errorDetail"]
  end
  rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'

  end
end
