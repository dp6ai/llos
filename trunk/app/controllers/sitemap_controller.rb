class SitemapController < ApplicationController

  layout :admin, :except => :sitemap

  def sitemap
    @types = Tag.types_asc :include => {:taggings => :taggable}
    @rooms = Tag.rooms_asc :include => {:taggings => :taggable}
    @outdoors = Tag.outdoors_asc :include => {:taggings => :taggable}
    @ranges = ProductRange.all_asc      
  end

end