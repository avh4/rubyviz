Given /^a sample ruby file, example1\.rb$/ do
  setup_safe_folder
  FileUtils.cp test_data_file("example1.rb"), project_folder_file("example1.rb")
end

When /^I execute "rubyviz example1\.rb"$/ do
  in_project_folder do
    capture_output "ruby -rubygems #{rubyviz_cmd} example1.rb"
    $?.exitstatus.should == 0
  end
end

Then /^the expect output file "example1\.rb\.png" should be produced$/ do
  File.exist?(project_folder_file("example1.rb.png")).should be_true
  if !File.exist?(test_data_file("example1.rb.png"))
    pending "test_data_file('example1.rb.png') needs to be created"
  end
  system "diff #{project_folder_file('example1.rb.png')} #{test_data_file('example1.rb.png')}"
  $?.exitstatus.should == 0
end
