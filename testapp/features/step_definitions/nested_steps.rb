ならば(/^(.*) \(非同期\)$/) do |nested_step|
  sleep 1
  step nested_step
end

もし(/^(.*) 新しいウインドウを開(?:き|いた)$/) do |nested_step|
  switch_to_window(window_opened_by { step nested_step })
end

もし(/^(.*) 通信を待(?:ち|った)$/) do |nested_step|
  step nested_step
  sleep 1
end
