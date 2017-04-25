class HomeController < ApplicationController
  def index
    @entries = Entry.order(created_at: :desc)
      .paginate page: params[:page], per_page: Settings.per_page
  end
end
