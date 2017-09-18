class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = session['spotify_user'].user_playlists(:id).pluck(:name)
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists
  # POST /playlists.json
  def create
    if params[:directions_start] && params[:directions_destination]
      directions = GoogleDirections.new(params[:directions_start], params[:directions_destination])
      unless directions.status == ("NOT_FOUND" || "OVER_QUERY_LIMIT")
        playlist_time = directions.drive_in_minutes
      end
    elsif params[:time][:hours] || params[:time][:minutes]
      playlist_time = params[:time][:hours].to_i * 60 + params[:time][:minutes].to_i
    end
    
    if params[:pool] == "genre"
      playlist_pool = params[:genre_seed]
    else
      playlist_pool = params[:pool]
    end
    
    puts "Playlist time: #{playlist_time}"
    puts "Playlist pool: #{playlist_pool}"
    
    

    # respond_to do |format|
    #   if @playlist.save
    #     format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
    #     format.json { render :show, status: :created, location: @playlist }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @playlist.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.fetch(:playlist, {})
    end
end
