require 'active_support/cache'
require 'json'
require 'rest-client'
require "getui/version"
require 'getui/errors'
require 'getui/auth'
require 'getui/message'
require 'getui/message/transmission'
require 'getui/apple'
require 'getui/request'
require 'securerandom'

module Getui
  extend self
  attr_accessor :app_id, :app_key, :master_secret, :cache_backend

  def push_single(cid, message)
    json = message.as_json
    json[:cid] = cid
    json[:requestid] = SecureRandom.uuid[0..29]
    resp = Getui::Request.post("https://restapi.getui.com/v1/#{Getui.app_id}/push_single", json)
    res = JSON.parse(resp.body)
    raise Getui::PushError.new("#{resp.body}") unless res["result"] == "ok"
    res
  end

  def save_list_body(message)
    json = message.as_json
    resp = Getui::Request.post("https://restapi.getui.com/v1/#{Getui.app_id}/save_list_body", json)
    res = JSON.parse(resp.body)
    raise Getui::PushError.new("#{resp.body}") unless res["result"] == "ok"
    res['taskid']
  end

  def push_list(cids, taskid, need_detail = true)
    json = {cid: cids, taskid: taskid, need_detail: need_detail}
    resp = Getui::Request.post("https://restapi.getui.com/v1/#{Getui.app_id}/push_list", json)
    res = JSON.parse(resp.body)
    raise Getui::PushError.new("#{resp.body}") unless res["result"] == "ok"
    res
  end

  def push_app(message)
    json = message.as_json
    json[:requestid] = SecureRandom.uuid[0..29]
    resp = Getui::Request.post("https://restapi.getui.com/v1/#{Getui.app_id}/push_app", json)
    res = JSON.parse(resp.body)
    raise Getui::PushError.new("#{resp.body}") unless res["result"] == "ok"
    res
  end

  def user_status(cid)
    resp = Getui::Request.get("https://restapi.getui.com/v1/#{Getui.app_id}/user_status/#{cid}")
    JSON.parse(resp.body)
  end

  def cache_backend
    if defined? Rails
      @cache_backend ||= Rails.cache
    else
      @cache_backend ||= ActiveSupport::Cache::MemoryStore.new
    end
  end

end
