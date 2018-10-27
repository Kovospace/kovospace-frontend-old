module BlogHelper

    def generate_post_url(post)
        if !@blog.blank?&&!@category.blank?
            return show_blog_category_post_path(blog_id: @blog.slug, category_id: @category.slug, id: post.slug, page: params[:page])
        elsif !@blog.blank?
            return show_blog_post_path(blog_id: @blog.slug, id: post.slug, page: params[:page])
        else
            return show_post_path(id: post.slug, page: params[:page])
        end
    end

    def blog_topmenu_link(route, name)
        output = "<li>"
        output += link_to(route) { "<span>#{name}</span>".html_safe }
        output += "</li>"
        output.html_safe
    end

end
