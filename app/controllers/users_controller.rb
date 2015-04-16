class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :finish_signup]
  before_action :set_idents, only: [:edit]
  before_filter :authenticate_user!

  # GET /users/:id.:format
  def show
    # authorize! :read, @user
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
    @user = current_user
    @parties = Party.all
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, bypass: true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update_attributes(user_params)
        sign_in(@user, bypass: true)
        redirect_to root_path, notice: 'Your profile was successfully updated.'
      else
        flash[:notice] = "Email already taken!  If you already have an account, login and with Facebook or Email and add your Twitter account on Settings page."
        @show_errors = true
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
    @user = current_user
    @ident = @user.identities.find_by(provider: "twitter")
    @ident.destroy!
    redirect_to root_path
  end

  def remove_facebook
    @user = current_user
    @ident = @user.identities.find_by(provider: "facebook")
    @ident.destroy!
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
      @user.post_code = params[:postcode]
      @user.constituency_id = @constituency.id
    if @user.save
      redirect_to :back
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end