class UsersController < ApplicationController
  skip_before_action :require_login
  skip_before_action :session_expiry
  
  def spotify
    session['spotify_user'] = RSpotify::User.new(request.env['omniauth.auth']).to_hash
    session[:expires_at] = Time.current + 1.hours
    
    puts "session[:expires_at]: #{session[:expires_at]}, Time.current: #{Time.current}"
    
    session['spotify_user_id'] = session['spotify_user']['id']
    
    puts session['spotify_user']
    puts session['spotify_user_id']
    puts session['spotify_user']['email']

    redirect_to root_path
  end
  
  def logout
    reset_session
    redirect_to root_path
  end

end