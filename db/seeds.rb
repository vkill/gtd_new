# encoding: utf-8
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
include Seed

p '> Initializing primary departments ...'
%w(财务处 后勤基建处 计算机工程系 图书信息中心).each do |name|
  Factory :department, :name => name, :describtion => ''
end
p '   %s departments were created.' % Department.count

p '> Initializing primary users ...'
%w(vkill jerry).each do |name|
  user = Factory :user, :name => name, :email => '%s@gmail.com' % name
  user.add_role! 'admin'
end
p '   %s users were created.' % User.count

#p '> Initializing primary services ...'
#p '    %s services were created.' % Service.count


p '> Generating test data'
_5_departments if Department.any?
Department.find_each do |department|
  services = _3_services :department => department
  users = _5_users :department => department
  users.each do |user|
    User.current = user
    posts = _3_posts :user => user
    softwares = _3_softwares :user => user
    softwares.each do |software|
      _1_attachment :attachmentable => software if rand(2) == 1
    end

    businesses = _3_businesses :user => user, :service => services.sample
    businesses.each do |business|
      _1_feedback :issue => business if rand(2) == 1
    end
  end
end
p '   done.'

