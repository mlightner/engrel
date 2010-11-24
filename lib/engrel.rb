require 'active_record'
require 'enumerated_attribute'
require 'engrel/sentence'
require 'engrel/prepositional_phrase'
require 'engrel/mixin'

# Helper methods that make creating new sentences a joy!
module Engrel
  module Helpers

    def sentence(*args, &block)
      Engrel::Sentence.claim(*args, &block)
    end
    alias :fact :sentence
    alias :claim :sentence

    module AciveRecordInstanceMethods
      def fact(verb, direct_object, &block)
        Engrel::Sentence.claim(self, verb, direct_object, &block)
      end
      alias :claim :fact
      alias :sentence :claim
    end

  end
end


ActiveRecord::Base.send(:include, ::Engrel::Helpers::AciveRecordInstanceMethods) if (defined?(ActiveRecord::Base) rescue false)
include ::Engrel::Helpers
