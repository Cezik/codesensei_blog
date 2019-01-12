class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @article = Article.accessible_by(current_ability, :index)
    # respond_to do |format|
    #   format.html
    #   format.json
    # end
  end

  def new
    @article = current_user.articles.new
    authorize! :new, @article
    render
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    authorize! :create, @article
    if @article.save
      flash[:success] = t('articles.create.success')
      redirect_to article_path(@article.id)
    else
      flash.now[:error] = t('articles.create.error',
                            problems: @article.errors.full_messages.to_sentence)
      render 'new' # z views/articles/new.html.rb
    end
  end

  def show
    @article = Article.find(params[:id])
    authorize! :show, @article
    @comment = @article.comments.new
  end

  def edit
    @article = Article.find(params[:id])
    authorize! :edit, @article
  end

  def update
    @article = Article.find(params[:id])
    authorize! :update, @article
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
    authorize! :destroy, article
    article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :author, :terms_of_service)
  end
end
