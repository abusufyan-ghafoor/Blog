class PostMailer < ApplicationMailer
    def new_post_email
        @post = params[:post]
        mail(to: @post.user.email, subject: "Post is Published!")
    end
end
