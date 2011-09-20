# encoding: utf-8
class HomeController < ApplicationController
  before_filter :get_news
  
  def index
    session[:go_to_after_edit] = root_path
    @photos = Photo.limit(4)

    
    case locale.to_s
      when 'dk' then @welcome = Page.welcome_dk
      when 'en' then @welcome = Page.welcome_en
    end
    
  end
end
