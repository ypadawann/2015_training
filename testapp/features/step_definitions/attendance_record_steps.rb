もし(/^(\d+) 年 (\d+) 月を選択した?$/) do |year, month|
  steps %{
    もし Year(#year) 欄に #{year} を入力し
    かつ Month(#month) 欄に #{month} を入力し
    かつ 表示(#date-select) ボタンをクリックし
    かつ 0.5 秒待った
  }
end

ならば(/^.*?\((.*?)\) 欄に今の年が入力され$/) do |element_id|
  page.has_field?(element_id, with: Date.today.year)
end

ならば(/^.*?\((.*?)\) 欄に今の月が入力され$/) do |element_id|
  page.has_field?(element_id, with: Date.today.month)
end

ならば(/^.*?\((.*?)\) 欄に今の年月が表示され$/) do |element_id|
  today = Date.today
  expect(page.find(element_id).text).to eq("#{today.year}年#{today.month}月")
end

ならば(/^添付ファイルがあ(?:り|る)$/) do
  expect(page.response_headers['Content-Disposition']).to start_with('attachment')
end

ならば(/^Content-Type が (.*?) であ(?:り|る)$/) do |type|
  expect(page.response_headers['Content-Type']).to eq(type)
end

もし(/^出勤結果欄に表示された出勤時間を記憶した?$/) do
  /\d\d?:\d\d/ =~ page.find('#attend-message').text
  @today_attendance = $&
end

ならば(/^今日の出勤時間欄に記憶した出勤時間が表示される?$/) do
  page.has_field?("#attendance#{Date.today.day}", with: @today_attendance)
end

もし(/^退勤結果欄に表示された退勤時間を記憶した?$/) do
  /\d\d?:\d\d/ =~ page.find('#leave-message').text
  @today_leaving = $&
end

ならば(/^今日の退勤時間欄に記憶した退勤時間が表示される?$/) do
  page.has_field?("#leaving#{Date.today.day}", with: @today_leaving)
end
