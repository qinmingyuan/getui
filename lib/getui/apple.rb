module Getui
  class Apns
    attr_accessor :auto_badge, :body, :payload, :title

    def initialize(body, title: '', payload: 'payload')
      @body = body
      @title = title
      @auto_badge = '+1'
      @payload = payload
      @content_available = 1
      @logo_url = 'http://cloud.1314-edu.com/EgEhXk3385iMGfCMSt3BtqrE'
    end

    def as_json
      {
        aps: {
          alert: {
            body: self.body,
            title: self.title,
          },
          autoBadge: @auto_badge,
          'content-available': @content_available,
        },
        payload: payload,
        multimedia: [
          {
            url: @logo_url,
            type: 1
          }
        ]
      }
    end
  end
end
