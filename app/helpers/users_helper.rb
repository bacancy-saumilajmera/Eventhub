# frozen_string_literal: true

module UsersHelper
  def is_super_admin?
    current_user.has_role? :super_admin
  end
end
