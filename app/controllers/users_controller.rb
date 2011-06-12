# encoding: utf-8
class UsersController < InheritedResources::Base
  load_and_authorize_resource
  
  respond_to :js, :only => [:create, :update]
  
  helper_method :sort_column, :sort_direction
  
  def index
    # def index  
    #   @products = Product.order(params[:sort])  
    # end
    
    @users = User.order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])
  end
  

#  def update 
#    
#    @user = User.find(params[:id])
#    @user.update_attributes(params[:user])
#    @user.image_content_type = MIME::Types.type_for(@user.image.original_filename).first.to_s if @user.image.original_filename.present?
#    @user.save
#    
#    update! {user_path(@user)}
#    
#  end

  

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      if params[:user][:image].blank?
        flash[:notice] = "Successfully updated user."
        redirect_to @user
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end

  
  def create  
    @user = User.new(params[:user])
    @user.image_content_type = MIME::Types.type_for(@user.image.original_filename).first.to_s if @user.image.original_filename.present?
    @user.save
    create! {user_path(@user)}
  end
  
  
  def password
    @user = if current_user.admin_or_super?
      User.find(params[:id])
    else
      current_user
    end
  end
  
  def crop
    
  end
    
private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  
end
