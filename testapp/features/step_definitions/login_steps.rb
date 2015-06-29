前提(/^(?::\s*)?id (.*?) ユーザ名 (.*?) パスワード (.*?) 部署 (.*?) 入社年月日 (.*?) が存在する$/) do |user_id, user_name, password, department_name, enter|
  visit "/test/add_department/#{department_name}"
  visit "/test/add_user/#{user_id}/#{user_name}/#{department_name}/#{password}/#{enter}"
end

もし(/^.*?\((.*?)\) にアクセスし、$/) do |path|
  visit path
end

もし(/^.*?\((.*?)\) に (.*?) を入力し、$/) do |element_id, value|
  page.find(element_id).set(value)
end

もし(/^[^\s]*?\((.*?)\) をクリックした$/) do |element_id|
  page.find(element_id).click
end

もし(/^モーダルの .*?\((.*?)\) をクリックした$/) do |element_id|
  page.find(element_id).trigger('click')
end

ならば(/^.*?\((.*?)\) にアクセスする$/) do |path|
  expect(page.current_path).to eq(path)
end

ならば(/^.*?\((.*?)\) が (.*?) である?$/) do |element_id, user_name|
  expect(page.find(element_id).text).to eq(user_name)
end
