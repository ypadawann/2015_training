# -*- coding: utf-8 -*-
もし(/^ログイン$/) do
  visit '/admin'
  page.find('#admin-id').set('admin')
  page.find('#admin-password').set('password')
  page.find('#admin-login').click
end

もし(/^".*?\((.*?)\)" にアクセス$/) do |t_path|
  visit t_path
end

もし(/^".*?\((.*?)\)" に以下を入力$/) do |t_css, t_doc|
  page.find(t_css).set(t_doc)
end


もし(/^".*?\((.*?)\)" をクリック$/) do |obj|
  page.find(obj).click
end


ならば(/^".*?\((.*?)\)" が存在$/) do |obj|
  page.find(obj)
end

ならば(/^アラートに "(.*?)" と表示$/) do |str|
  #wait_for_ajax
  #p alert = page.driver.browser.switch_to.alert_message unless Capybara.javascript_driver == :poltergeist
  #p alert = page.driver.alert_messages
  #expect(alert).to eq(str)
  #alert = page.driver.browser.switch_to.alert
  page.driver.alert_messages
end

ならば(/^".*?\((.*?)\)" に "(.*?)" と表示$/) do |obj, str|
  #wait_for_ajax if t_async
  wait_for_ajax
  target_elem = page.find(obj)
  case target_elem.tag_name
  when 'input', 'option'
    expect(target_elem.value).to eq(str)
  else
    expect(target_elem.text).to eq(str)
  end
end

ならば(/^".*?\((.*?)\)" で "(.*?)" が選択$/) do |obj, str|
  #wait_for_ajax if t_async
  wait_for_ajax
  selected_id = page.find(:xpath, "//html/body/p/select").value
  expect(page.find(:xpath, "//html/body/p/select/option[@value = #{selected_id}]").text).to eq(str)
end

ならば(/^管理者画面トップに移動$/) do
  page.find('#admin-user')
  page.find('#admin-department')
  page.find('#admin-admin')
  page.find('#to-admin-register')
  page.find('#admin-logout')
end

ならば(/^部署管理画面に移動$/) do
  page.find('#department-delete')
  page.find('#department-rename')
  page.find('#department-register')
end

ならば(/^ユーザ情報管理画面に移動$/) do
  page.find('#user-select')
  page.find('#user-modify')
  page.find('#user-delete')
end
