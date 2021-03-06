前提(/^(?::\s*)?部署 (.*?) が存在(?:し|する)$/) do |department_name|
  visit "/test/add_department/#{department_name}"
end

前提(/^(?::\s*)?社員番号 (.*?), 名前 (.*?), 所属 (.*?), パスワード (.*?), 入社年月日 (.*?) のユーザが存在(?:し|する)$/) do |id, name, department, password, enter|
  visit "/test/add_user/#{id}/#{name}/#{department}/#{password}/#{enter}"
end

もし(/^.*?\((.*?)\) 画面にアクセスした?$/) do |path|
  @visited_path = path
  visit path
end

もし(/^.*?\((.*?)\) 欄に (.*?) を入力した?$/) do |element_id, value|
  page.find(:css, element_id).set(value)
end

もし(/^以下を入力した?$/) do |table|
  table.raw.each do |element|
    element_id, value = element
    m = /.*?\((.*?)\)$/.match(element_id)
    page.find(:css, m[1]).set(value)
  end
end

もし(/^.*?\((.*?)\) 欄から (.*?) を選択した?$/) do |element_id, value|
  page.find(:css, element_id, visible: false).find(:option, value, visible: false).select_option
end

もし(/^.*?\((.*?)\) ボタンをクリックした?$/) do |element_id|
  page.find(:css, element_id).click
end

もし(/^(.*?) リンクをクリックした?$/) do |element_id|
  page.find_link(element_id).click
end

ならば(/^ページタイトルは (.*?) であ(?:り|る)$/) do |title|
  expect(page.title).to eq(title)
end

ならば(/^.*?\((.*?)\) 画面に遷移(?:し|する)$/) do |path|
  sleep 0.5
  @visited_path = page.current_path
  expect(page.current_path).to eq(path)
end

ならば(/^画面遷移(?:せず|しない)$/) do
  expect(page.current_path).to eq(@visited_path)
end

ならば(/^.*?\((.*?)\) 欄に (.*?) が表示される?$/) do |element_id, value|
  expect(page.find(element_id).text).to eq(value)
end

ならば(/^.*?\((.*?)\) 欄に何も表示され(?:ず|ない)$/) do |element_id|
  expect(page.find(element_id).text).to eq('')
end

ならば(/^.*?\((.*?)\) 欄に (.*?) を含む表示がされる?$/) do |element_id, value|
  page.find(element_id).has_text?(value)
end

ならば(/^(.*?) を含むアラートが表示される?$/) do |text|
  elements = page.all('.alert-message').find { |elem| elem.text.include?(text) }
  expect(elements).not_to be_nil
end

ならば(/^以下が表示される?$/) do |table|
  wait_for_ajax
  table.raw.each do |element|
    element_id, value = element
    m = /.*?\((.*?)\)$/.match(element_id)
    expect(page.find(m[1]).text).to eq(value)
  end
end

ならば(/^.*?\((.*?)\) 欄に (.*?) が入力される?$/) do |element_id, value|
  page.has_field?(element_id, with: value)
end

ならば(/^以下が入力される?$/) do |table|
  wait_for_ajax
  table.raw.each do |element|
    element_id, value = element
    m = /.*?\((.*?)\)$/.match(element_id)
    page.has_field?(m[1], with: value)
  end
end

ならば(/^.*?\((.*?)\) 欄から (.*?) が選択される?$/) do |element_id, value|
  page.has_select?(element_id, selected: value)
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
