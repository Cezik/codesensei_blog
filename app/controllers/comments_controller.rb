class CommentsController < ApplicationController

  before_action :load_article

  def create
    # Sprawdźmy, czy przypadkiem nie powinniśmy tworzyć tu komentarza dla
    # obrazka, artykułu, a nie całego atykułu
    if params[:picture_id].present?
      @picture = @article.pictures.find(params[:picture_id])
    end

    @comment = (@picture || @article).comments.new(comment_params)

    if @comment.save
      flash[:success] = t('comments.create.success')
      if @picture.present?
        redirect_to article_picture_path(@article.id, @picture.id) and return
      else
        redirect_to article_path(@article.id) and return
      end
      flash[:error] = t('comments.create.error',
                        problems: @comment.errors.full_messages.to_sentence)

      if @picture.present?
        render 'pictures/show'
      else
        render 'articles/show'
      end
    end
  end

  # GET /articles/:article_id/comments/:id/edit
  def edit
  if params[:picture_id].present?
    @picture = @article.pictures.find(params[:picture_id])
  end

  @comment = (@picture || @article).comments.find(params[:id])
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
                            problems: @comment.errors.full_messages.to_sentence)

      render 'edit' # TODO: Poinformować,co się nie udało
    end
  end

  # DELETE /articles/:article_id/comments/:id
  def destroy
    # @article = Article.find(params[:article_id])
    # @comment = @article.comments.find(params[:id])
    if params[:picture_id].present?
      @picture = @article.pictures.find(params[:picture_id])
    end

    @comment = (@picture || @article).comments.find(params[:id])
    @comment.destroy
    if @picture.present?
      redirect_to article_picture_path(@article.id, @picture.id) and return
    else
      redirect_to article_path(@article.id) and return
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def load_article
    @article = Article.find(params[:article_id])
  end
end
