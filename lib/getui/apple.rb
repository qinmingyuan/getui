module Getui
  class Apns
    attr_writer :body, :title, :auto_badge, :sound, :content_available, :payload, :multimedia

    def initialize(body, title: '', payload: {}, multimedia: [], **options)
      @body = body
      @title = title
      @auto_badge = options.delete(:auto_badge) || '+1'
      @sound = options.delete(:sound)
      @content_available = options.delete(:content_available) || 1
      @payload = payload
      @multimedia = multimedia
    end

    def as_json
      {
        aps: {
          alert: {
            body: @body,
            title: @title,
          },
          autoBadge: @auto_badge,
          'content-available': @content_available,
        },
        payload: @payload,
        multimedia: @multimedia
      }
    end
  end
end
