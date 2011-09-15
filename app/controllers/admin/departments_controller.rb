class Admin::DepartmentsController < Admin::BaseController

  load_and_authorize_resource

  main_nav_highlight :basic
  sec_nav_highlight :departments

end

