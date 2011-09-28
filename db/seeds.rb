# encoding: utf-8
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

FactoryGirl.factories.clear
FactoryGirl.definition_file_paths << Rails.root.join('spec', 'support', 'factories').to_s
FactoryGirl.find_definitions
include Seed

p '> Initializing primary departments ...'
%w(财务处 后勤基建处 计算机工程系 图书信息中心).each do |name|
  Factory :department, :name => name, :describtion => ''
end
p '   %s departments were created.' % Department.count

p '> Initializing primary roles ...'
%w(admin chief staff).each do |code|
  Factory :role, :name => code, :code => code, :describtion => ''
end
role_admin = Role.find_by_code(:admin)
p '   %s roles were created.' % Role.count

p '> Initializing primary users ...'
%w(vkill.net jerry).each do |name|
  user = Factory :user, :name => name, :email => '%s@gmail.com' % name
  user.roles << role_admin
  user.superadmin = true
  user.save!
end
p '   %s users were created.' % User.count

#p '> Initializing primary services ...'
#p '    %s services were created.' % Service.count

