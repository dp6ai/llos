class StaticContentController < ApplicationController
  def home
    @meta_description = t(:meta_home_description)
    @meta_keywords = t(:meta_home_keywords)
    @meta_title = t(:meta_home_title)
  end

  def heritage
    @meta_description = t(:meta_heritage_description)
    @meta_keywords = t(:meta_heritage_keywords)
    @meta_title = t(:meta_heritage_title)

  end

  def history
    @meta_description = t(:meta_history_description)
    @meta_keywords = t(:meta_history_keywords)
    @meta_title = t(:meta_history_title)
  end

  def production
    @meta_description = t(:meta_production_description)
    @meta_keywords = t(:meta_production_keywords)
    @meta_title = t(:meta_production_title)
  end

  def media
    @meta_description = t(:meta_media_description)
    @meta_keywords = t(:meta_media_keywords)
    @meta_title = t(:meta_media_title)
  end

  def contact
    @meta_description = t(:meta_contact_description)
    @meta_keywords = t(:meta_contact_keywords)
    @meta_title = t(:meta_contact_title)
  end

  def legal
    @meta_description = t(:meta_legal_description)
    @meta_keywords = t(:meta_legal_keywords)
    @meta_title = t(:meta_legal_title)
  end

  def faq
    @meta_description = t(:meta_faq_description)
    @meta_keywords = t(:meta_faq_keywords)
    @meta_title = t(:meta_faq_title)
  end

  def brochure
    @meta_description = t(:meta_brochure_description)
    @meta_keywords = t(:meta_brochure_keywords)
    @meta_title = t(:meta_brochure_title)
  end

  def standard
    @meta_description = t(:meta_standard_description)
    @meta_keywords = t(:meta_standard_keywords)
    @meta_title = t(:meta_standard_title)
  end

  def naturals
    @meta_description = t(:meta_naturals_description)
    @meta_keywords = t(:meta_naturals_keywords)
    @meta_title = t(:meta_naturals_title)
  end

  def loomtex
    @meta_description = t(:meta_loomtex_description)
    @meta_keywords = t(:meta_loomtex_keywords)
    @meta_title = t(:meta_loomtex_title)
  end

  def outdoor
    @meta_description = t(:meta_outdoor_description)
    @meta_keywords = t(:meta_outdoor_keywords)
    @meta_title = t(:meta_outdoor_title)
  end

  def farrow_and_ball
    @meta_description = t(:meta_other_description)
    @meta_keywords = t(:meta_other_keywords)
    @meta_title = t(:meta_other_title)
  end

  def accessories
    @meta_description = t(:meta_access_description)
    @meta_keywords = t(:meta_access_keywords)
    @meta_title = t(:meta_access_title)
  end

  def fabric
    @meta_description = t(:meta_fabric_description)
    @meta_keywords = t(:meta_fabric_keywords)
    @meta_title = t(:meta_fabric_title)
  end

end
