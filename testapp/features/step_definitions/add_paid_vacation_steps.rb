もし(/^.*?\((.*?)\) に (.*?) を入力する$/) do |element_id, value|
  page.find(element_id).set(value)
end

ならば(/^.*?\((.*?)\) に (.*?) と表示する$/) do |alert, message|
  wait_for_ajax
  target_elem = page.all(alert).last
  case target_elem.tag_name
  when 'input', 'option'
    expect(target_elem.value).to eq(message)
  else
    expect(target_elem.text).to eq(message)
  end
end
