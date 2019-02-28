module Getui
  class Message
    attr_writer :push_info

    def initialize(message_type, is_offline: true, offline_expire_time: 7 * 24 * 60 * 60, push_network_type: 0)
      @message_type = message_type
      @is_offline = is_offline
      @offline_expire_time = offline_expire_time
      @push_network_type = push_network_type
    end

    def as_json
      {
        appkey: Getui.app_key,
        is_offline: @is_offline,
        offline_expire_time: self.offline_expire_time,
        push_network_type: @push_network_type,
        msgtype: @message_type
      }
    end

    def offline_expire_time
      @offline_expire_time * 1000
    end

  end
end
