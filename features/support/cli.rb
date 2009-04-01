module CliHelpers
  def rubyviz_cmd
    @rubyviz_cmd ||= File.expand_path(File.dirname(__FILE__) + "/../../../../bin/rubyviz")
  end
end

World { |world| world.extend CliHelpers }
