path = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH << path unless $LOAD_PATH.include?(path)
require 'tag'
require 'tagging'

module IsTaggable
  class TagList < Array
    cattr_accessor :delimiter
    @@delimiter = ','
    
    def initialize(list)
      list = list.is_a?(Array) ? list : list.split(@@delimiter).collect(&:strip)
      super
    end
    
    def to_s
      join(', ')
    end
  end

  module ActiveRecordExtension
    def is_taggable(*kinds)
      class_inheritable_accessor :tag_kinds
      self.tag_kinds = kinds.map(&:to_s).map(&:singularize)
      self.tag_kinds << :tag if kinds.empty?

      include IsTaggable::TaggableMethods
    end
  end

  module TaggableMethods
    def self.included(klass)
      klass.class_eval do
        include IsTaggable::TaggableMethods::InstanceMethods

        has_many   :taggings, :as      => :taggable, :dependent => :destroy
        has_many   :tags,     :through => :taggings
        after_save :save_tags

        tag_kinds.each do |k|
          define_method("#{k}_list")  { get_tag_list(k) }
          define_method("#{k}_list=") { |new_list| set_tag_list(k, new_list) }
        end
      end
    end

    module InstanceMethods
      def set_tag_list(kind, list)
        logger.debug "MSP set_tag_list: #{kind} :#{list}"
        tag_list = TagList.new(list)
        logger.debug "MSP set_tag_list2: #{kind} :#{list}"
        instance_variable_set(tag_list_name_for_kind(kind), tag_list)
      end

      def get_tag_list(kind)
        logger.debug "MSP get_tag_list: #{kind}"

        tags.each { |tag| logger.debug "MSP tag:#{tag.name}" }

#        logger.debug "MSP get_tag_list map2: #{tags.of_kind(kind)}" #MSP whats up with this ?!? Breaks with i18n can't use of_kind

#        set_tag_list(kind, tags.of_kind(kind).map(&:name)) if tag_list_instance_variable(kind).nil?
        set_tag_list(kind, tags.collect{|t| t if t.kind == kind}.compact.map(&:name)) if tag_list_instance_variable(kind).nil?
        logger.debug "MSP get_tag_list2: #{kind}"
        tag_list_instance_variable(kind)
      end

      protected
        def tag_list_name_for_kind(kind)
          ret = "@#{kind}_list"
          logger.debug "MSP: tag_list_name_for_kind #{ret}"
          ret
        end
        
        def tag_list_instance_variable(kind)
          logger.debug "MSP tag_list_instance_variable: #{kind} "
          ret = instance_variable_get(tag_list_name_for_kind(kind))
          logger.debug "MSP tag_list_instance_variable2 ret: #{ret} "
          ret
        end

        def save_tags
          tag_kinds.each do |tag_kind|
            delete_unused_tags(tag_kind)
            add_new_tags(tag_kind)
          end

          taggings.each(&:save)
        end
        
        def delete_unused_tags(tag_kind)
#          tags.of_kind(tag_kind).each { |t| tags.delete(t) unless get_tag_list(tag_kind).include?(t.name) }
          tags.collect{|t| t if t.kind == tag_kind}.compact.each { |t| tags.delete(t) unless get_tag_list(tag_kind).include?(t.name) }
        end

        def add_new_tags(tag_kind)
#          tag_names = tags.of_kind(tag_kind).map(&:name)
          tag_names = tags.collect{|t| t if t.kind == tag_kind}.compact.map(&:name)
          get_tag_list(tag_kind).each do |tag_name| 
            tags << Tag.find_or_initialize_with_name_like_and_kind(tag_name, tag_kind) unless tag_names.include?(tag_name)
          end
        end
    end
  end
end

ActiveRecord::Base.send(:extend, IsTaggable::ActiveRecordExtension)
