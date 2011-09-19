module Admin::BusinessesHelper

  def current_user_issue_accepters
    if current_user.has_role? 'admin'
      User.not_superadmin.search({"department_id_is_not_null" => true}).all(:order => :name)
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

  def admin_issue_state_operation(record)
    case record.state
    when :pending
      if can? :assign, record
        link_to t("web.change_state.issue.to_assigned"),
                [:assign, :admin, record],
                :title => t("web.change_state.issue.to_assigned"),
                "data-colorBox-ajax-load" => ""
      end
    when :assigned
      if can? :accept, record and current_user == record.accepter
        link_to t("web.change_state.issue.to_accepted"),
                [:accept, :admin, record],
                :title => t("web.change_state.issue.to_accepted"),
                "data-colorBox-ajax-load" => ""
      end
    when :accepted
      if can? :finish, record and current_user == record.accepter
        link_to t("web.change_state.issue.to_finished"),
                [:finish, :admin, record],
                :title => t("web.change_state.issue.to_finished"),
                "data-colorBox-ajax-load" => ""
      end
    when :finished
      raw("&nbsp"*6)
    when :expired
      raw("&nbsp"*6)
    end
  end

  def issue_state_operation(record)
    case record.state
    when :pending
      raw("&nbsp"*6)
    when :assigned
      raw("&nbsp"*6)
    when :accepted
      raw("&nbsp"*6)
    when :finished
      raw("&nbsp"*6)
    when :expired
      raw("&nbsp"*6)
    end
  end

  def issue_feedback_add(record)
    if can? :add_feedback, record and current_user == record.editor
      link_to t("web.change_state.feedback.add"),
              [:add_feedback, record],
              :title => t("web.change_state.feedback.add"),
              "data-colorBox-ajax-load" => ""
    end
  end

  def admin_issue_feedback_state_operation(record)
    case record.feedback.state
    when :pending
      if can? :process_feedback, record
        link_to t("web.change_state.feedback.to_processing"),
                [:process_feedback, :admin, record],
                :title => t("web.change_state.feedback.to_processing"),
                "data-colorBox-ajax-load" => ""
      end
    when :processing
      if can? :process_feedback, record
        link_to t("web.change_state.feedback.to_processed"),
                [:process_feedback, :admin, record],
                :title => t("web.change_state.feedback.to_processed"),
                "data-colorBox-ajax-load" => ""
      end
    when :processed
      raw("&nbsp"*6)
    end
  end

  def issue_feedback_state_operation(record)
    case record.feedback.state
    when :pending
      raw("&nbsp"*6)
    when :processing
      raw("&nbsp"*6)
    when :processed
      raw("&nbsp"*6)
    end
  end
end

