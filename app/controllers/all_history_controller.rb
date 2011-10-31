class AllHistoryController < ApplicationController
      before_filter :get_news
    def index
      @history = Page.history_dk
      @gallery = Gallery.history
    end

  end
