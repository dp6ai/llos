class ProductsController < ApplicationController

  def index
    # display a single products details and show other products in range as thumbs 
    if !params[:product].blank? && !params[:id].blank?
      @product = Product.find(params[:id])
      @products_in_range = []
      if !@product.product_range.blank?
        @products_in_range = Product.all_in_range(@product.product_range.id)
      end

      @meta_description = strip_html(textilize(@product.description))
      @meta_title = @product.range_and_name
    else

      # collect the products in a category
      @selected_category =
        case params[:category_kind]
          when "type" then
            @types.collect{|c| c if c.name.downcase == params[:category].downcase}.compact.first
          when "room" then
            @rooms.collect{|c| c if c.name.downcase == params[:category].downcase}.compact.first
          when "outdoor" then
            @outdoors.collect{|c| c if c.name.downcase == params[:category].downcase}.compact.first
          when "range" then
            @ranges.collect{|c| c if c.name.downcase == params[:category].downcase}.compact.first
        end

      # and sort by highlighted in category
      @selected_category.taggings.sort!{|x, y| y.highlighted <=> x.highlighted } if params[:category_kind] != "range" && @selected_category


      @meta_title = "Lloyd Loom of Spalding - #{@selected_category.name}" if @selected_category 

      # display the range page with description, location pic  and show other products in range as thumbs
      if params[:category_kind] == "range"
        # pick any prod and use the DB (easy pagination) to show the others in the range
        @products_in_range = []
        if !@selected_category.products.blank?
          product = @selected_category.products.first
          if !product.product_range.blank?
            @products_in_range = Product.all_in_range(product.product_range.id)

            if !params[:selected_id].blank?
            #  @products_in_range.reject!{|p| p.id == params[:selected_id].to_i}
              @selected = Product.find(params[:selected_id])
            #  @products_in_range.insert(0, selected)
            end
          end
        end


        @highlighted_product = @selected_category.products.collect{|c| c if c.highlighted}.compact.first #in a range
        @meta_description = @highlighted_product.nil? ? "" :  strip_html(textilize(@highlighted_product.description))
        @meta_title = @highlighted_product.nil? ? "Lloyd Loom of Spalding - #{@selected_category.name}" :  @highlighted_product.range_and_name
      end
    end

  end


  def type
    redirect_to :action => :index
  end

  def room
    redirect_to :action => :index
  end

  def outdoor
    redirect_to :action => :index
  end

  def range
    redirect_to :action => :index
  end
end