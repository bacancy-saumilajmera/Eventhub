# frozen_string_literal: true

class UsersController < ApplicationController
  def all_users
    @user = User.all
  end

  def add_admin_role
    @user = User.find(params[:id])
    @user.remove_role :user
    @user.add_role :admin
    redirect_to all_users_path
  end

  def remove_admin_role
    @user = User.find(params[:id])
    @user.remove_role :admin
    @user.add_role :user
    redirect_to all_users_path
  end
end
