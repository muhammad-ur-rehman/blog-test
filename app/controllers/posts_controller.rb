# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save!
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def follow
    @post = Post.find(params[:id])
    current_user.follow(@post)
    respond_to do |format|
      format.html { redirect_to @post}
      format.js
    end
  end

  def unfollow
    @post = Post.find(params[:id])
    current_user.unfollow(@post)
    respond_to do |format|
      format.html {redirect_to @post}
      format.js
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
