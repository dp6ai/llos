# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  before_filter :set_locale
  before_filter :populate_product_nav
  before_filter :set_meta_tags
  before_filter :instantiate_controller_and_action_names

  around_filter do |controller, action|
    #logger.debug "MSP2 previous_action_name #{controller.session[:previous_action_name]}"
    action.call
    controller.session[:previous_action_name] = controller.action_name
  end


  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e01bd221bffc9963c3154fc9d1d4b42c'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end

  def assign_lovs
    @types_lov = Tag.types_asc.collect { |cat| [cat.name, cat.id] }
    @rooms_lov = Tag.rooms_asc.collect { |cat| [cat.name, cat.id] }
    @outdoors_lov = Tag.outdoors_asc.collect { |cat| [cat.name, cat.id] }
  end

  LOCALES = {"uk" => "en", "com" => "en"}
  def extract_locale_from_tld
    _parsed_locale = request.host.split('.').last

    # parsed locales are symbols, not strings
    parsed_locale = (I18n.available_locales.include? _parsed_locale.intern) ? _parsed_locale : nil

    keyed_locale = !LOCALES[parsed_locale].blank? ? LOCALES[parsed_locale] : parsed_locale
    return keyed_locale
  end

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    if !params[:lang].blank?
      I18n.locale = params[:lang]
      session[:lang] = params[:lang] 
    else
      if !session[:lang].blank?
        I18n.locale = session[:lang]
      else
        I18n.locale = extract_locale_from_tld
      end
    end
  end

  def set_meta_tags
    @meta_description = t(:meta_default_description)
    @meta_keywords = t(:meta_default_keywords)
    @meta_title = t(:meta_default_title)
  end

  def populate_product_nav
    @types = Tag.types_asc :include => {:taggings => :taggable}
    @rooms = Tag.rooms_asc :include => {:taggings => :taggable}
    @outdoors = Tag.outdoors_asc :include => {:taggings => :taggable}
    @ranges = ProductRange.all_asc
    @weaves = Weave.all_by_sort_order_asc
    @fabrics = Fabric.all_asc
  end

  def strip_html(s)
    return s.gsub(/<\/?[^>]*>/, "")
  end

end
