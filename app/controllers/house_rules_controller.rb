class HouseRulesController < ApplicationController
  before_filter :get_news
  def index
    @house_rules = Page.house_rules
  end

end
