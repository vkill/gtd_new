module Admin::UsersHelper
  def user_state_operation(record)
    case record.state
    when /^(pending|paused)$/
      link_to( t("web.change_state.user.to_actived"),
                admin_user_path(record, :event => "actived"),
                :title => t("web.change_state.user.to_actived"),
                :method => :put,
                :confirm => t(:confirm)
                ) + raw("&nbsp") +
      link_to( t("web.change_state.user.to_deleted"),
                admin_user_path(record, :event => "deleted"),
                :title => t("web.change_state.user.to_deleted"),
                :method => :put,
                :confirm => t(:confirm)
                )
    when :actived
      link_to( t("web.change_state.user.to_paused"),
                admin_user_path(record, :event => "paused"),
                :title => t("web.change_state.user.to_paused"),
                :method => :put,
                :confirm => t(:confirm)
                ) + raw("&nbsp") +
      link_to( t("web.change_state.user.to_deleted"),
                admin_user_path(record, :event => "deleted"),
                :title => t("web.change_state.user.to_deleted"),
                :method => :put,
                :confirm => t(:confirm)
                )
    when :deleted
      link_to t("web.change_state.user.to_pending"),
                admin_user_path(record, :event => "pending"),
                :title => t("web.change_state.user.to_pending"),
                :method => :put,
                :confirm => t(:confirm)
    end
  end
end

