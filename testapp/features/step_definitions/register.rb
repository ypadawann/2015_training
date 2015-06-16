前提(/^(?::\s*)?部署 (.*?) が存在(?:し|する)$/) do |department_name|
  visit "/test/add_department/#{department_name}"
end

もし(/^.*?\((.*?)\) 画面にアクセスした?$/) do |path|
  visit path
end

もし(/^.*?\((.*?)\) 欄に (.*?) を入力した?$/) do |element_id, value|
  page.find(:css, element_id).set(value)
end

もし(/^.*?\((.*?)\) 欄から (.*?) を選択した?$/) do |element_id, value|
  page.find(:css, element_id).find(:option, value).select_option
end

もし(/^.*?\((.*?)\) ボタンをクリックした?$/) do |element_id|
  page.find(:css, element_id).click
end

ならば(/^.*?\((.*?)\) 画面に遷移(?:し|する)$/) do |path|
  sleep 1
  expect(page.current_path).to eq(path)
end

ならば(/^.*?\((.*?)\) 欄に (.*?) が表示される?$/) do |element_id, value|
  expect(page.find(element_id).text).to eq(value)
end

ならば(/^HTTPステータスコードは (.*?) であ(?:り|る)$/) do |status|
  expect(page.status_code).to eq(status.to_i)
end

ならば(/^スクリーンショットを保存(?:し|する)$/) do
  save_screenshot('screen_shot.png')
end

ならば(/^ページを保存(?:し|する)$/) do
  save_page('page.html')
end
