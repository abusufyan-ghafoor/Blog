class CommentsController < ApplicationController
    before_action :set_post, only: [:create, :destroy]
    def create
        @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))
        @comment.save
        redirect_to post_path(@post)
    end
    def destroy
        @comment = @post.comments.find_by_id(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end
    private
    def comment_params
        params.require(:comment).permit(:body)
    end
    def set_post
        @post = Post.find_by_id(params[:post_id])
    end
end
