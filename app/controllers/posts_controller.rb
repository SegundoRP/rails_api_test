class PostsController < ApplicationController
  include Secured
  # ese include esta llamando al concern secured
  before_action :authenticate_user, only: [:create, :update]

  rescue_from Exception do |e|
    # log.error "#{e.message}"  esto enviaria el mensaje de error a los encargados del sistema
    render json: { error: e.message }, status: :internal_error
    # este es el mensaje 500 esto resuelve cualquier exception que aparezca
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { error: e.message }, status: :unprocessable_entity # esto resuelve los exceptions de create o update que hayan
  end

  def index
    @posts = Post.where(published: true)
    if !params[:search].nil? && params[:search].present?
      @posts = PostsSearchService.search(@posts, params[:search])
    end
    render json: @posts.includes(:user), status: :ok
  end

  def show
    @post = Post.find(params[:id])
    if (@post.published? || (Current.user && @post.user_id == Current.user.id))
      render json: @post, status: :ok
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def create
    @post = Current.user.posts.create!(create_params) #tanto para el create y update ! hace que cuando hay error levanta una excepcion y las excepciones se tratan con rescue_from
    render json: @post, status: :created
  end

  def update
    @post = Current.user.posts.find(params[:id])
    @post.update!(update_params)
    render json: @post, status: :ok
  end

  private

  def create_params
    params.require(:post).permit(:title, :content, :published, :user_id)
  end

  def update_params
    params.require(:post).permit(:title, :content, :published)
  end
end
