ならば(/^(.*) \(非同期\)$/) do |nested_step|
  sleep 1
  step nested_step
end
