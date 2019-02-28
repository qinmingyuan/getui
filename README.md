# Getui

Getui Ruby SDK

## 使用

```ruby
apns = Getui::Apns.new(body, title: title, payload: {})
message = Getui::Message::Transmission.new(apns: apns)

Getui.push_single(receiver.getui_token, message)
```
