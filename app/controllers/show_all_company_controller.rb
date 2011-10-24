class ShowAllCompanyController < ApplicationController
  before_filter :get_news
  
  def show
    @company = Company.find(params[:id])
    @link = '<a href="http://'+@company.homepage+'">'+@company.homepage+'<a/>'
    if user_signed_in?
      @newsposts = Newspost.internal.order('created_at desc').paginate(:per_page => 3, :page => params[:page])
    end
  end

end
