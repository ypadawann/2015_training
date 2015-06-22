# -*- coding: utf-8 -*-
前提 (/^管理者にID "(.*?)"、パスワード "(.*?)" が存在$/) do |id, pass|
  visit "/test/admin-init/#{id}/#{pass}"
end

前提 (/^ユーザにID "(.*?)"、名前 "(.*?)"、部署 "(.*?)"、パスワード "(.*?)"、入社日 "(.*?)" が存在$/) do |id, name, department, pass, enter |
  visit "/test/user-init/#{id}/#{name}/#{department}/#{pass}/#{enter}"
end

前提(/^部署 "(.*?)" が存在$/) do |department|
  visit "/test/department-init/#{department}"
end

もし(/^".*?\((.*?)\)" にアクセス$/) do |t_path|
  visit t_path
end

もし(/^".*?\((.*?)\)" に "(.*?)" を入力$/) do |t_css, t_doc|
  page.find(t_css).set(t_doc)
end


もし(/^".*?\((.*?)\)" をクリック$/) do |obj|
  page.find(obj).click
end

もし(/^".*?\((.*?)\)" で "(.*?)" を選択$/) do |select_obj, target_opt|
  box = page.find(select_obj)
  box.select(target_opt)
end

 
もし(/^".*?\((.*?)\)" が存在$/) do |obj|
  page.find(obj)
end

もし(/^".*?\((.*?)\)" に "(.*?)" と表示$/) do |obj, str|
  wait_for_ajax
  target_elem = page.all(obj).last
  case target_elem.tag_name
  when 'input', 'option'
    expect(target_elem.value).to eq(str)
  else
    expect(target_elem.text).to eq(str)
  end
end

もし(/^".*?\((.*?)\)" で "(.*?)" が選択$/) do |element_id, str|
  wait_for_ajax
  #p page.has_select?(element_id, selected: value)
  #obj = page.find(:xpath, "//select[@id='select-department']/option[@selected='selected']")
  select_element = page.find(element_id)
  selected_id = select_element.value
  expect(select_element.find(:xpath, "//option[@value=#{selected_id}]").text).to eq(str)
end

もし(/^"(.*?)" 秒待機$/) do | second |
  sleep second.to_f
end

もし(/^アラートをチェック$/) do
  within ".modal-footer" do
    page.find('.alert-message')
  end
end
