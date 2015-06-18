ならば(/^(.*) \(非同期\)$/) do |nested_step|
  sleep 1
  step nested_step
end

もし(/^(.*) 新しいウインドウを開(?:き|いた)$/) do |nested_step|
  switch_to_window(window_opened_by { step nested_step })
end

もし(/^(\d+\.\d*) 秒待(?:ち|った)$/) do |sec|
  sleep sec.to_f
end
