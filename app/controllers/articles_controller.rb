class ArticlesController < ApplicationController

  def index
    @article = Article.all
    # respond_to do |format|
    #   format.html
    #   format.json
    # end
  end

  def new
    @article = Article.new
    render
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = t('articles.create.success')
      redirect_to article_path(@article.id)
    else
      flash.now[:error] = t('articles.create.error',
      problems: @article.errors.full_messages.to_sentence
      )
      render 'new' # z views/articles/new.html.rb
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      # redirect_to article_path(@article.id)
      flash[:success] = t('articles.update.success')
      redirect_to @article
    else
      flash.now[:error] = t('articles.update.error',
      problems: @article.errors.full_messages.to_sentence
      )
      render 'edit' # TODO: Poinformować,co się nie udało
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :author, :terms_of_service)
  end
end
