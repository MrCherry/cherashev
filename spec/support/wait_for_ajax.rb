module WaitForAjax
  def wait_for_xhr
    wait_for_ajax(jquery: false)
  end

  def wait_for_jquery
    wait_for_ajax(jquery: true)
  end

  private

  def wait_for_ajax(jquery: true)
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?(jquery: false)
    end
  end

  def finished_all_ajax_requests?(jquery: true)
    if jquery
      page.evaluate_script('jQuery.active').zero?
    else
      !page.evaluate_script('XMLHttpRequest.active')
    end
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end
