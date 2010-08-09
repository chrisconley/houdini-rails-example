require 'net/http'
require 'uri'

When /houdini posts back the answer:$/ do |table|
  rack_test_session_wrapper = Capybara.current_session.driver

  table.hashes.each do |answer_params|
    subject_class = answer_params.delete("subject_class")
    subject_id = answer_params.delete("subject_id")
    task_name = answer_params.delete("task_name")

    answer_params.each_pair do |name, value|
      if value =~ /^\{\{.+\}\}$/
        value = value.gsub(/^\{\{/, '').gsub(/\}\}$/, '')
        answer_params[name] = eval(value)
      else
        answer_params[name] = ActiveSupport::JSON.decode(value)
      end
    end

    postback_path = houdini_postbacks_path(subject_class, subject_id, task_name)
    rack_test_session_wrapper.post(postback_path, :answer => answer_params)
  end
end

Then /a request to houdini should be sent later$/ do
  job = Delayed::Job.last
  job.should_not be_nil
  job.name.should eql('Post#send_to_houdini')
  job.payload_object.perform
end