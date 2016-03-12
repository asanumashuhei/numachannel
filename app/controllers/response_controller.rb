class ResponseController < ApplicationController
  def res
    respose = Response.create(res_content: params[:res_content], topic_id: params[:topic_id])
    redirect_to '/top'
  end
end
