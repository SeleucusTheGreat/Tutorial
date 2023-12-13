class SearchController < ApplicationController
  def index
    @query = Post.ransack(params[:q])
    @result = @query.result(distinct: true)
  end
end
