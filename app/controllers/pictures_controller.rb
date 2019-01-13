class PicturesController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    authorize! :index, @article
    @pictures = @article.pictures.accessible_by(current_ability, :index)
  end

  def new
    @article = Article.find(params[:article_id])
    @picture = @article.pictures.new
    authorize! :new, @picture
  end

  def create
    @article = Article.find(params[:article_id])
    @picture = @article.pictures.new(picture_params)
    authorize! :create, @picture

    if @picture.save
      redirect_to article_pictures_path

    else
      flash.now[:error] = t('pictures.create.error',
                        default: 'Obrazek nie mógł zostać zapisany')
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:article_id])
    @picture = @article.pictures.find(params[:id])
    authorize! :edit, @picture
  end

  def update
    @article = Article.find(params[:article_id])
    @picture = @article.pictures.find(params[:id])
    authorize! :update, @picture

    if @picture.update(picture_params)
      redirect_to article_picure_path(@article, @picture)
    else
      flash.now[:error] = t('pictures.update.error', default: 'Nie można zapisać obrazka')
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @picture = @article.pictures.find(params[:id])# rescue nil
    authorize! :destroy, @picture
    @picture.destroy
    redirect_to article_pictures_path(@article)
  end

  def show
    @article = Article.find(params[:article_id])
    @picture = @article.pictures.find(params[:id])# rescue nil
    @comment = @picture.comments.new
    authorize! :show, @picture
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :description, :image)
  end
end
