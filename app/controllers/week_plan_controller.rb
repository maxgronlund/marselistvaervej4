class WeekPlanController < ApplicationController
  before_filter :get_news
  def index
    @week_plan = Page.week_plan
  end

end
