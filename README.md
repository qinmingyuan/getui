# Getui

Getui Ruby SDK

## 使用

```ruby
apns = Getui::Apns.new(self.body, title: self.title)
message = Getui::Message::Transmission.new('请填写透传内容')
message.apns = apns

Getui.push_single(receiver.getui_token, message)
```
