class TopicsController < ApplicationController
 before_action :twitter_client, except: :new

  def index
    @topics = Topic.all.order(created_at: :desc).page(params[:page])
    # @topics = Topic.page(params[:page])
    @word = params[:word]
    @find = Topic.where('body LIKE(?)', "%#{params[:word]}%").count
    u_info = User.find(session[:user_id])
    @provider = u_info.provider
  end

  def twitter_client
    @client = User.twitter_client
  end

  def uri(status)
    @uri = []
    @client.search(status, :locale => "ja", :result_type => "recent", :include_entity => true).take(100).map do |tweet|
        if tweet.media?
            tweet.media.each do |value|
                  @uri << params[:uri_info] = value.media_uri
            end
        end
    end

  end

  def create
    topic = Topic.create(body: params[:body])
    status = topic.body
    body = topic.body
    body_ini = body[0]
    u_info = User.find(session[:user_id])
    provider = u_info.provider


    if body_ini == "#"
      uri(status)
      redirect_to action: 'index', params: { aaa: @uri[0..4]}

    elsif provider == "twitter"
      @client.update(status)
      redirect_to '/top'
    else
      auth = request.env["omniauth.auth"]
      access_token = "CAACEdEose0cBAMZBfevJ0vYqeg6ZC9RgGCCZATUHcUZAI4yDG7WpZAK7x3ZCf8dlnxrHofNX17RbV94ZAUz5pmeza9XFDSO8eAmGZC8n7d49utD63zJmZAt78azSSPzx2EeKZCnROTGn5d6aFZCQeUai6YJ0dKvQjZB2dNSDjKFGZAVWKAZB2TXeSlYE4cUeo8AF1lx8BcFwAyNX2MhggtbSZAztECi"
      graph = Koala::Facebook::API.new(access_token)
      graph.put_wall_post(status)
      redirect_to '/top'
      end
    end

    def edit
    topic = Topic.find(params[:id])
    topic.update_attribute(:body, params[:edit_content])
    redirect_to '/top'
    end
end

