class TagsController < ApplicationController
    
    before_action :set_auth!
    before_action :set_to_follow!
    before_action :set_tags!
    before_action :set_new_post!


    def index
        @posts = Post.all
        if user_signed_in?
          @newPost = Post.new
          @followers_count = current_user.followers.count
        end
        # setting up code for the tokeninput field
        @tags = Tag.where("name like ?", "%#{params[:q]}%")
        respond_to do |format|
            format.html
            format.json { render :json => @tags.map(&:attributes) }

        end
    end

    def new
        @newTag = Tag.new
    end

    def create
        @tag = Tag.new(tag_params)
        respond_to do |f|
            if (@tag.save)
                f.html {redirect_to "/", notice: "Tag created!" }
            else
                f.html {redirect_to "", notice: "Error: Tag not saved."}
            end
        end
    end

    def show
        #find categorizations for the given tag

        #find posts which are in those categorizations
        @tag = Tag.find(params[:id])
        @posts = @tag.posts


        if user_signed_in?
          @newPost = Post.new
          @followers_count = current_user.followers.count
        end
        respond_to do |format|
          format.html
          format.js
        end
    end

    private
    def tag_params # allows certain data to be passed via form.
        params.require(:tag).permit(:name)
    end
    
end
