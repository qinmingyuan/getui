module Getui
  class Message
    class Transmission < Getui::Message
      attr_writer :apns

      def initialize(transmission_content, is_offline: true, offline_expire_time: 7 * 60 * 60 * 24, push_network_type: 0, **options)
        super('transmission', is_offline: is_offline, offline_expire_time: offline_expire_time, push_network_type: push_network_type)
        @transmission_type = false
        @transmission_content = transmission_content
        @apns = options[:apns]
      end

      def as_json
        message_json = super
        json = {
          message: message_json,
          transmission: {
            transmission_type: @transmission_type,
            transmission_content: @transmission_content,
          },
        }
        json[:push_info] = @apns.as_json if @apns
        json
      end
    end
  end
end
