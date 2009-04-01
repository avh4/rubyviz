Given /^a sample ruby file, example1\.rb$/ do
  setup_safe_folder
  FileUtils.cp test_data_file("example1.rb"), project_folder_file("example1.rb")
end

When /^I execute "rubyviz example1\.rb"$/ do
  in_project_folder do
    capture_output "#{rubyviz_cmd}"
    $?.exitstatus.should == 0
  end
end

Then /^the expect output file example1\.png should be produced$/ do
  File.exist?(project_folder_file("example1.png")).should be_true
  if !File.exist?(test_data_file("example1.png"))
    pending "test_data_file('example1.png') needs to be created"
  end
  system "diff #{project_folder_file('example1.png')} #{test_data_file('example1.png')}"
  $?.exitstatus.should == 0
end
