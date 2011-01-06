class SearchController < ApplicationController
  ## THIS NEEDS A WHOLE RETHINK!
  skip_before_filter :verify_authenticity_token #BAAAAAD
  def index
    @search = Search.new(params[:search])
    logger.debug("MSP: search: #{@search.to_s}")
    logger.debug("MSP: search: #{@search.get_search}")

    @taggings = []
    if @search.has_search
      @taggings = Tagging.products_with @search.get_search
    end

  end
  
end
