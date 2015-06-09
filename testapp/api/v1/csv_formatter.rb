
require 'csv'

module API
  module V1
    module CSVFormatter
      def export_csv(contents, year, month)
        CSV.generate do |csv|
          csv << ['勤務管理表']
          csv << ['年月', "#{year}年#{month}月"]
          csv << ['所属', contents[:department]]
          csv << ['No.', contents[:user_id]]
          csv << ['氏名', contents[:name]]

          csv << [
            '日付',
            '曜日',
            '入室時刻',
            '退出時刻',
            '上司承認印',
            '深夜勤務',
            '休日勤務時間',
            '振替休日予定日',
            '有給休暇',
            '振替休日取得日',
            '時間外業務は必ず上司による指示を受けてください。'
          ]
          contents[:data].each do |d|
            csv << [
              d[:day],
              d[:weekday],
              d[:attendance],
              d[:leaving],
              '',
              d[:midnight_work],
              d[:holiday_shift],
              d[:prearranged_holiday],
              d[:paid_vacation],
              d[:holiday_acquisition],
              d[:etc]
            ]
          end
          csv << [
            '合計',
            '',
            '',
            '',
            '',
            contents[:total][:midnight_work],
            contents[:total][:holiday_shift],
            '',
            contents[:total][:paid_vacation]
          ]
        end
      end
    end
  end
end
