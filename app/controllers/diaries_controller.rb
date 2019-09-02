class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  # GET /diaries
  # GET /diaries.json
  def index
    @diaries = @current_user.diaries.all.order(created_at: :desc)
     .paginate(page: params[:page], per_page: 10)
    
  end

  # GET /diaries/1
  # GET /diaries/1.json
  def show
    @user = @diary.user
  end

  # GET /diaries/new
  def new
    @diary = Diary.new
  end

  # GET /diaries/1/edit
  def edit
  end

  # POST /diaries
  # POST /diaries.json
  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = @current_user.id

    respond_to do |format|
      if @diary.save
        format.html { redirect_to @diary, notice: '今日も最高の1日でしたね！' }
        format.json { render :show, status: :created, location: @diary }
      else
        format.html { render :new }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diaries/1
  # PATCH/PUT /diaries/1.json
  def update
    respond_to do |format|
      if @diary.update(diary_params)
        format.html { redirect_to @diary, notice: '最高の編集が完了しました！' }
        format.json { render :show, status: :ok, location: @diary }
      else
        format.html { render :edit }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diaries/1
  # DELETE /diaries/1.json
  def destroy
    @diary.destroy
    respond_to do |format|
      format.html { redirect_to diaries_url, notice: '日記を削除しました。新しいものを書きましょう！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = @current_user.diaries.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diary_params
      params.require(:diary).permit(:title, :body, :content, :user_id)
    end
    
    def ensure_correct_user
      @diary = Diary.find_by(id: params[:id])
      if @diary.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/")
      end
    end
    
    
end
