require 'mechanize'

class PostsController < ApplicationController
  def index
    @potential_users = PotentialUser.all
  end

  def scrape
    agent = Mechanize.new
    urls_with_role = %w{mnh brk que brx stn}.map do |borough|
      [["hou", "finder"], ["abo", "lister"], ["sub", "lister"]].map do |type, role|
        ["#{borough}/#{type}", role]
      end
    end.flatten(1)

    urls_with_role.each do |path, user|
      page = agent.get("http://newyork.craigslist.org/#{path}")
      links = page.search('blockquote p a')

      links.each do |link|
        href = link.attributes.first.last.value
        if match = href.match(/\/(\d+).html/)
          external_id = match[1]
          unless Post.exists?(:external_id => external_id)
            page = agent.get(href) rescue nil
            if page
              post = Post.new(:external_id => external_id,
                              :href => href,
                              :user => user)

              post_links = page.search('body.posting a:first-of-type')
              post_links.each do |post_link|
                post_link_href = post_link.attributes.first.last.value
                if email_match = post_link_href.match(/mailto:(.*)\?/)
                  post.email = email_match[1]
                end
              end

              post.save
            end
          end
        end
      end
    end
    redirect_to posts_path
  end

  def email_one_remailer_user
    posts = Post.all(:conditions => ["email like ?", "%craigslist%"], :order => "created_at desc", :limit => 1000)

    user = PotentialUser.latest_remailer_user

#    return if user.created_at > 20.minutes.ago
    post = if user.is_a?(PotentialLister)
      posts.detect { |p| p.user == "finder" && !PotentialUser.exists?(:email => p.email) }
    else
      posts.detect { |p| p.user == "lister" && !PotentialUser.exists?(:email => p.email) }
    end

    post = posts.detect { |p| !PotentialUser.exists?(:email => p.email) } unless post

    "Potential#{post.user.camelize}".constantize.create(:email => post.email) if post
  end
end
