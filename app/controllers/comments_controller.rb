class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
    def create 
        
        @comment = @post.comments.create(comment_param)
        @comment.user = current_user

        if @comment.save
            flash[:notice] = "comment has been created"
            redirect_to post_path(@post)
        else
            flash[:alert] = "comment has not been created"
        end
    end

    def destroy
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end

    def update
        @comment = @post.comments.find(params[:id])

        respond_to do |format|
            if @comment.update(comment_param)
                format.html { redirect_to post_url(@post), notice: "comment has been updated"}
            else
                format.html { redirect_to post_url(@post), alert: "comment has not been updated!"}
            end
        end
    end

    private 

    def set_post
        @post = Post.find(params[:post_id])
    end

    def comment_param
        params.require(:comment).permit(:body)
    end
end
