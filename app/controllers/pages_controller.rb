class PagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      # Dùng pagy thay paginate
      @pagy, @microposts = pagy(
       current_user.feed.newest,
           items: 5
        )
    end
  end
end
