require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(image_file)
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      base64_image = Base64.encode64(open("#{Rails.root}/public/uploads/#{image_file.id}").read)

      params = {
        requests: [{
          image: {
            content: base64_image,
          },
          features: [
            {
              type: 'LABEL_DETECTION',
            },
          ],
        }],
      }.to_json

      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)

      JSON.parse(response.body)['responses'][0]['labelAnnotations'].pluck('description').take(3)
    end
  end
end
