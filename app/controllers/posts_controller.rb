class PostsController < ApplicationController
  #we are setting a particular user's post by set post except all post method
  before_action :set_user_to_post, except: [:all_posts, :create, :index]

  # it will render all post present in application
  def all_posts
    @post = Post.all
    render json: @post
  end

  #By this method we get post of user which has logged in with specific post id
  def show
    if @post
      render json: @post
      # render json: { title: @post.title, content: @post.content} #we also can see only title and name of post by uncommenting code
    else
      render json: {message: "no post available"}
    end
  end

  def index
    @post = $user.posts.all
    render json: @post
  end

  # By this method we create a post by the user which have been logged in.
  def create
    return render json: {message: "user should be present but no user found"} if $user == nil #if there is no user then display message
    post = $user.posts.build(post_params)
    if post.save
      render json: {message: "post created successfully created by user with id #{$user.id}  and post id #{post.id}"}
    else
      render json: { error: post.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  # here we are updating specific post by providing id
  def update
    if @post.update(post_params)
      render json: {message: "post updated successfully"}
    else
      render json: { error: @post.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  #here we deleting specific post also providing the specific id that can delete the post
  def destroy
    if @post.destroy
      render json: { message: 'Post deleted successfully' }
    else
      render json: {message: 'check your access and try again'}
    end
  end

  private

  #this method will provide current user
  def set_user_to_post
    begin
      @post = $user.posts.find(params[:id])
    rescue
      render json: {message: "no post with given id for current user"}
    end
  end

  # Here the method is giving permission that which variable name can pass into parametres
  def post_params
    params.require(:post).permit(:title, :content)
  end
end