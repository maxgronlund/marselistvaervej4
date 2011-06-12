class HistoryController < ApplicationController
    before_filter :get_news
  def index
    session[:go_to_after_edit] = history_index_path
    @history = Page.history_dk
  end

end
