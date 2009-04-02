Given /^a sample ruby file, (.*\.rb)$/ do |example|
  setup_safe_folder
  @test_file = test_data_file(example)
  FileUtils.cp test_data_file(example), project_folder_file(File.basename(example))
end

When /^I execute "rubyviz ([^"]*)"$/ do |cmd|
  in_project_folder do
    capture_output "#{rubyviz_cmd} #{cmd}"
    if $?.exitstatus != 0
      fail File.read(output_of("#{rubyviz_cmd} #{cmd}"))
    end
  end
end

Then /^the expected output file "([^"]*)" should be produced$/ do |file|
  @test_file.should_not be_nil
  File.exist?(project_folder_file(file)).should be_true
  if !File.exist?(@test_file + ".png")
    FileUtils.cp project_folder_file(file), "failed_#{file}"
    pending "#{@test_file}.png needs to be created"
  end
  capture_output "diff #{project_folder_file(file)} #{@test_file}.png"
  if $?.exitstatus != 0
    FileUtils.cp project_folder_file(file), "failed_#{file}"
    fail "Files did not match (#{file})"
  end
end
