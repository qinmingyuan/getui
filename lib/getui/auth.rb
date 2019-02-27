require 'rest-client'
require 'digest'
require 'json'

module Getui
  module Auth
    class << self
      def auth_token
        Getui.cache_backend.fetch("Getui:#{Getui.app_id}:auth_token", expires_in: 12.hours) do
          Getui::Auth.generate
        end
      end

      def generate
        timestamp = DateTime.now.strftime('%Q')
        resp = Net::HTTP.post(
          URI("https://restapi.getui.com/v1/#{Getui.app_id}/auth_sign"),
          {
            timestamp: timestamp,
            sign: Digest::SHA256.new.hexdigest("#{Getui.app_key}#{timestamp}#{Getui.master_secret}"),
            appkey: Getui.app_key
          }.to_json,
          {
            "Content-Type" => "application/json"
          }
        )
        res = JSON.parse(resp.body)
        raise Getui::GenerateAuthTokenError.new(resp.body) unless res["result"] == "ok"
        res["auth_token"]
      end
    end
  end
end
