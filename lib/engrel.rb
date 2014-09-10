require 'rubygems'
require 'active_support'
require 'active_record'
require 'enumerated_attribute'
require 'engrel/sentence'
require 'engrel/prepositional_phrase'
require 'engrel/mixin'

# Helper methods that make creating new sentences a joy!
module Engrel
  module Helpers

    # Creates a new relation from scratch--that is, without an implicit subject.  Takes arguments in the order they would be written in
    # an anglish sentence.
    #
    # @param [Object] an object, usually an actor.
    # @param [Symbol] a verb from the vast pre-approved list that decsribes this relation.
    # @param [Object] the direct object in this
    # @returns [Sentence] The new Sentence object created to represent this relation.
    def sentence(*args, &block)
      Engrel::Sentence.claim(*args, &block)
    end
    alias :fact :sentence
    alias :claim :sentence

    module ActiveRecordInstanceMethods
      # Helper method that gets included into AR::Base that allows any model object to specify a relationship between it and any other
      # object (the direct object (they're both polymorphic, of course).
      #
      # @param [Symbol] The downcased, underscored word representing the transitive verb i.e. (:is_friends_with)
      # @param [Object] The direct object that is the second receiver for the trasitive verb above.
      # @returns [Sentence] The new Sentence object created to represent this relation.
      def fact(verb, direct_object, &block)
        Engrel::Sentence.claim(self, verb, direct_object, &block)
      end
      alias :claim :fact
      alias :sentence :claim
    end

  end
end


ActiveRecord::Base.send(:include, ::Engrel::Helpers::ActiveRecordInstanceMethods) if (defined?(ActiveRecord::Base) rescue false)
include ::Engrel::Helpers
