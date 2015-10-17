class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :finish_signup, :edit]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_idents, only: [:edit]
  before_action :profile_action, only: [:show]
  skip_filter :check_email_format
  before_filter :authenticate_user!

  # GET /users/:id.:format
  def show
    # authorize! :read, @user
    @votes = @user.votes
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
    @parties = Party.all
    @constituency = @user.constituency
    @mp = @constituency.mp if @constituency
    @s3_direct_user_image = S3_BUCKET.presigned_post(key: "uploads/user_photos/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)

    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  # PATCH/PUT /users/:id.:format
  def update_info
    # authorize! :update, @user
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, bypass: true)
        format.html { redirect_to root_path, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    unless @user.email.include? "change@me"
      redirect_to edit_user_path(@user.id)
    else
    # authorize! :update, @user 
      if request.patch? && params[:user] && params[:user][:email]
        if @user.update_attributes(user_params)
          sign_in(@user, bypass: true)
          redirect_to edit_user_path(@user.id), notice: 'Your profile was successfully updated.'
        else
          flash[:notice] = "Email blank or already taken!  If you already have an account, try logging in with either Facebook or Email."
          @show_errors = true
        end
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def remove_twitter
    current_user.identities.find_by(provider: "twitter").destroy!

    redirect_to root_path
  end

  def remove_facebook
    current_user.identities.find_by(provider: "facebook").destroy!

    redirect_to root_path
  end

  def add_post_code_join_constituency
    require 'open-uri'
    encoded_url_3 = URI.encode("http://www.doogal.co.uk/ShowMap.php?postcode=#{params[:postcode]}")
    @doc_3 = Nokogiri::HTML(open(encoded_url_3))
    @node = @doc_3.xpath('//td[text()="Constituency: "]').first
    constituency_name_web = @node.next_element.text
    @constituency = Constituency.find_by(name: constituency_name_web)
    @user = User.find(params[:id])
    @mp = @constituency.mp if @constituency
      @user.post_code = params[:postcode]
      @user.constituency_id = @constituency.id
    if @user.save
      respond_to do |format|
        format.html {redirect_to :back}
        format.js {render :partial => 'show_user_mp.js.erb'}
      end
    else
      redirect_to edit_user_path(current_user.id)
    end
  end

  def add_user_to_party
    @party = Party.find_by(name: params[:party_name])
    @parties = Party.all
    @user = User.find(params[:id])
      @user.party_id = @party.id
    if @user.save
      respond_to do |format|
        format.html {redirect_to :back}
        format.js {render :partial => 'add_user_to_party.js.erb'}
      end
    end
  end

  def followers
    @users = current_user.followers
  end

  def following
    @users = current_user.followed_users
  end

  def send_mp_notification_fb
    Resque.enqueue(NotifyMpFb, params[:content], current_user.id)
    respond_to do |format|
      format.js {render :partial => 'close_notify_modal_fb.js.erb'}
    end
  end

  def send_mp_notification_tw
    Resque.enqueue(NotifyMpTw, params[:content], current_user.id)
    respond_to do |format|
      format.js {render :partial => 'close_notify_modal_tw.js.erb'}
    end
  end

  def send_mp_email
    Resque.enqueue(NotifyMpEmail, params[:content], current_user.id)
    respond_to do |format|
      format.js {render :partial => 'close_notify_modal_email.js.erb'}
    end
  end

  def accepted_terms
    user = current_user
      user.accepted_terms = true
    user.save

    respond_to do |format|
      format.js {render :partial => 'close_notify_modal_terms.js.erb'}
    end
  end

  
  private
    def set_user
      if User.where(id: params[:id]).any?
        @user = User.find(params[:id])
      else
        redirect_to root_path
      end
    end

    def user_params
      accessible = [ :name, :email, :allow_profile_view, :bio, :fb_link, :tw_link, :insta_link, :youtube_link, :web_link, :street_addr, :city, :phone, :picture_url ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end

    def profile_action
      @user = User.find(params[:id])
      if @user.allow_profile_view
        redirect_to bills_path
      end
    end

    def correct_user
      unless @user == current_user
        redirect_to root_path
      end
    end

    def set_idents
      @idents = []

      if user_signed_in?
        current_user.identities.each do |i|
          @idents << i.provider
        end
      end
    end
end