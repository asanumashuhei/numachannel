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
      access_token = "CAACEdEose0cBAIugv1XZBLZC8tbvst2LGVaOpTZCDbTg4ZCTxuvQRB3zg9PxoTCpqMjZAKK5lFzZAReHX4hIFwYCurcFi3UjvLu0njg6iAgy6i6VtsZA4xCuDDeR2sPA5NChpzmHFnaul2BbBtf1iqZApxvwpa4563OKZA04MOMeyMrbOd7nnZB9ZAQWj4zzADrAPywbjZAJzR4ZC6mda14IXglEB"
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

