class CommentsController < ApplicationController

  before_action :load_article

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      flash[:success] = t('comments.create.success')
      redirect_to article_path(@article.id)
    else
      flash[:error] = t('comments.create.error',
      problems: @comment.errors.full_messages.to_sentence)

      render 'articles/show'
    end
  end

  # GET /articles/:article_id/comments/:id/edit
  def edit
    @comment = @article.comments.find(params[:id])
  end

  # PATCH/PUT /articles/:article_id/comments/:id
  def update
    # @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = t('comments.update.success')
      redirect_to article_path(@article.id)
    else
      flash.now[:error] = t('comments.update.error',
      problems: @comment.errors.full_messages.to_sentence
      )
      render 'edit' # TODO: Poinformować,co się nie udało
    end
  end

  # DELETE /articles/:article_id/comments/:id
  def destroy
    @article = Article.find(params[:article_id])
    comment = @article.comments.find(params[:id])
    comment.destroy
    redirect_to article_path(@article.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def load_article
    @article = Article.find(params[:article_id])
  end
end
