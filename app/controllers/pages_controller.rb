class PagesController < ApplicationController
  before_action :check, only: [:top]

  def check
    if !logged_in_user? && !logged_in_teacher?
      redirect_to login_index_url, info: 'ログインしてください'
    end
  end

  def index
    render layout: 'default.html.erb'
  end

  def top
  end

end
