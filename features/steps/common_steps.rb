Given /^a sample ruby file, (.*\.rb)$/ do |example|
  setup_safe_folder
  FileUtils.cp test_data_file(example), project_folder_file(example)
end

When /^I execute "rubyviz ([^"]*)"$/ do |cmd|
  in_project_folder do
    capture_output "ruby -rubygems #{rubyviz_cmd} #{cmd}"
    if $?.exitstatus != 0
      fail File.read(output_of("ruby -rubygems #{rubyviz_cmd} #{cmd}"))
    end
  end
end

Then /^the expected output file "([^"]*)" should be produced$/ do |file|
  File.exist?(project_folder_file(file)).should be_true
  if !File.exist?(test_data_file(file))
    pending "test_data_file(file) needs to be created"
  end
  capture_output "diff #{project_folder_file(file)} #{test_data_file(file)}"
  if $?.exitstatus != 0
    FileUtils.cp project_folder_file(file), "failed_#{file}"
    fail "Files did not match (#{file})"
  end
end
