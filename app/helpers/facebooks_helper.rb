module FacebooksHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_facebooks_path
    elsif action_name == 'edit'
      facebook_path
    end
  end
end
