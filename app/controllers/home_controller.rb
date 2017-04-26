class HomeController < ApplicationController
  def index
    @entries = Entry.order(created_at: :desc)
      .paginate page: params[:page], per_page: Settings.per_page
    if logged_in?
      @user_follows = "SELECT followed_id FROM relationships
      WHERE  follower_id = #{current_user.id}"
      @new_feed = Entry.where("user_id IN (#{@user_follows})
        OR user_id = #{current_user.id}").order(created_at: :desc)
        .paginate page: params[:page], per_page: Settings.per_page
    end
  end
end
