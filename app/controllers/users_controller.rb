class UsersController < ApplicationController
  inherit_resources
  actions :show, :edit, :update, :destroy
  before_action :require_user_login!
  before_action :correct_user

  def update
    update!(notice: 'Your preferences have been successfully updated.')
    find_matches(@user)
  end

  def render_matches
    user = User.find(params[:id])
    friend_count = user.get_friends.length
    if user.job_status == 'finished'
      render partial: 'matches/index', locals: { matches: @user.matches }
    else
      render text: "Searched through #{user.progress_bar} of your #{friend_count} friends..."
    end
  end

  private

    def user_params
      params.require(:user).permit(:match_gender, :match_relationship_status, :match_location, :match_religion)
    end

    def correct_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Sorry, you can't view that page."
      redirect_to root_url unless current_user?(@user)
    end

    def find_matches(user)
      matches = FacebookMatcher.new(@user)
      begin
        user.update(job_status: 'processing')
        matches.delay.get_friend_data
      rescue Exception => e
        user.update(job_status: 'error')
      end
    end
end
