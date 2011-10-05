class InfoController < ApplicationController
    before_filter :get_news
  def index
    session[:go_to_after_edit] = info_index_path
    @history = Page.info
  end

end
