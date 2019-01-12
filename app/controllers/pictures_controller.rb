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
    # TODO: obsłużyć błędy
    @picture.save!
    redirect_to article_pictures_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :description, :image)
  end
end
