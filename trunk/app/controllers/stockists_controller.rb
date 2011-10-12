class StockistsController < ApplicationController
  def index
  end

  def msp
  end

  def search
    if params["latitude"].present? && params["longitude"].present?
      render :json => Stockist.near([params["latitude"].to_f, params["longitude"].to_f], 80)[0..2].to_json
    end
  end
end