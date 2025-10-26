class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = Review.all.order(created_at: :desc)
  end

  def show
  end

  def new
    Rails.logger.info "=== DEBUG INFO ==="
    Rails.logger.info "current_user: #{current_user.inspect}"
    Rails.logger.info "user_signed_in?: #{user_signed_in?}"
    Rails.logger.info "==================="
  
    @review = Review.new
  end

  def create
    unless current_user
    redirect_to new_user_session_path, alert: 'ログインしてください'
    return
  end
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to @review, notice: 'レビューを登録しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'レビューを更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: 'レビューを削除しました。'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:orchestra, :conductor, :music, :impression)
  end
end
