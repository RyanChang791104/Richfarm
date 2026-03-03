require 'xcodeproj'
project_path = '/Users/rychang/Desktop/richfarm_ios/richfarm_ios.xcodeproj'
project = Xcodeproj::Project.open(project_path)

target = project.targets.first
group = project.main_group.find_subpath(File.join('richfarm_ios'), true)

Dir.glob('/Users/rychang/Desktop/richfarm_ios/richfarm_ios/*View.swift').each do |file|
  unless group.files.any? { |f| f.path == File.basename(file) }
    file_ref = group.new_reference(file)
    target.add_file_references([file_ref])
    puts "Added #{File.basename(file)} to project."
  end
end

project.save
puts "Project saved successfully."
