require 'active_support'

module Engrel
  module Mixin
    extend ActiveSupport::Concern

    module ClassMethods
      # Who knows--maybe I'll think of something to put here someday.
    end
    
    module InstanceMethods

      # This is very specific to Facebook--it stores a reference to the object through whose access token the intermediate object was initially fetched.
      def set_fetcher!(newfetcher = nil)
        write_attribute(:fetcher_id, newfetcher[:id])
        write_attribute(:fetcher_type, newfetcher.class.to_s)
        save(:validate => false)
        reload
        fetcher
      end

      # Make sure we can make an object before we go trying to save the "association".
      def instantiate_object!(key)
        key = key.to_sym
        id_key, type_key = "#{key}_id".to_sym, "#{key}_type".to_sym
        return true if !self[key].blank? && !(self[key][:id].blank? rescue true)
        class_name = self[type_key] || (self.send(key).class.to_s rescue "Page")
        raise "Could not determine class name for #{key} (#{self.to_s})" if class_name.blank?
        newid = self[id_key] || (self[key][:id] rescue nil)
        class_name.constantize.spec(newid) rescue raise("Unable to instantiate #{class_name} object with ID #{newid || '[unavailable]'}")
      end
    end
  end
end
