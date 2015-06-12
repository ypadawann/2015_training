module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      loop do
        sleep 0.01
        break if page.evaluate_script('jQuery.active').zero?
      end
    end
  end
end

World(WaitForAjax)
