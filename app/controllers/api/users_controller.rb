class Api::UsersController < Api::BaseController
  # http_basic_authenticate_with :name => "myfinance", :password => "credit123"

  skip_before_filter :verify_authenticity_token
  # skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :authenticate_user!, :except => [:create, :forgot_password] # we do not need devise authentication here
  before_filter :fetch_user, :except => [:index, :create]

  respond_to :json
  def fetch_user
    @user = User.find_by_id(params[:id])
  end

  def index
    @users = User.all
    respond_to do |format|
      format.json { render json: @users }
      format.xml { render xml: @users }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @user }
      format.xml { render xml: @user }
    end
  end

  def create
    # respond_to do |format|
    #   format.json { render json: params.require(:user).permit(:email, :password, :password_confirmation), status: :created }
      # params.require(:user).permit(:email, :password, :password_confirmation)
    # end
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
    # @user.temp_password = Devise.friendly_token
    respond_to do |format|
      if @user.save
        format.json { render json: @user, status: :created }
        format.xml { render xml: @user, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def forgot_password
    email = params[:email]

    if email.nil?
       render :status=>400,
              :json=>{:message=>"The request must contain the user email."}
       return
    end

    user = User.find_by_email(email.downcase)

    if user.nil?
      logger.info("User #{email} failed forgot password, user cannot be found.")
      render :status=>401, :json=>{:message=>"Invalid email."}
      return
    end

    user.send_reset_password_instructions

    # respond_to do |format|
    #   format.json { render json: { :result => true }, status: :ok }
    #   format.xml { render xml: { :result => true }, status: :ok }
    # end
    respons_to_format(:ok, true, '')
  end

  private

  def respons_to_format(status, result, msg)
    respond_to do |format|
      format.json { render json: { :result => result, :message => msg }, status: status }
      format.xml { render xml: { :result => result, :message => msg }, status: status  }
    end
  end
end
