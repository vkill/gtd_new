module Admin::BusinessesHelper

  def current_user_issue_accepters
    if current_user.has_role? 'admin'
      User.not_superadmin(:order => :name)
    elsif current_user.has_role? 'chief'
      current_user.department.users.not_superadmin(:order => :name)
    else
      []
    end
  end

  def resource_issue_services
    if resource.class.name == 'Business'
      Service.all(:order => :name)
    elsif resource.class.name == 'Task'
      if current_user.has_role? 'admin'
        Service.all(:order => :name)
      elsif current_user.has_role? 'chief'
        current_user.department.services(:order => :name)
      else
        []
      end
    else
      []
    end
  end

  def admin_state_operation(record)

    case record.state
    when :pending
      link_to( t("web.change_state.issue.to_assigned"),
                [:assign, :admin, record],
                :title => t("web.change_state.issue.to_assigned"),
                "data-colorBox-ajax-load" => ""
                )
    when :assigned
      raw("&nbsp"*6)
#      link_to( t("web.change_state.issue.to_accepted"),
#                "#",
#                :title => t("web.change_state.issue.to_accepted")
#                "data-colorBox-ajax-load" => ""
#                )
    when :accepted
      raw("&nbsp"*6)
#      link_to( t("web.change_state.issue.to_processing"),
#                "#",
#                :title => t("web.change_state.issue.to_finished")
#                "data-colorBox-ajax-load" => ""
#                )
    when :finished
      raw("&nbsp"*6)
    when :expired
      raw("&nbsp"*6)
    end
  end

  def admin_feedback_state_operation(record)
    case record.feedback.state
    when :pending
      link_to t("web.change_state.feedback.to_processing"),
        [:process_feedback, :admin, record],
        :title => t("web.change_state.feedback.to_processing"),
        "data-colorBox-ajax-load" => ""
    when :processing
      link_to t("web.change_state.feedback.to_processed"),
        [:process_feedback, :admin, record],
        :title => t("web.change_state.feedback.to_processed"),
        "data-colorBox-ajax-load" => ""
    when :processed
      raw("&nbsp"*6)
    end
  end
end

