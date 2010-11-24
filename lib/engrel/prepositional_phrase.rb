require 'engrel/mixin'

class Engrel::PrepositionalPhrase < ActiveRecord::Base
  include Engrel::Mixin

  # This whole top declaration will need changing if you're not using AR.
  set_table_name "engrel_prepositional_phrases"

  # A prepositional phrase, which answers the questions: how?, which one?, when? with whom? by whom? etc.
  # http://www.chompchomp.com/terms/prepositionalphrase.htm
  belongs_to :indirect_object, :polymorphic => true

  # The sentence that owns us.
  belongs_to :sentence, :class_name => "::Engrel::Sentence"

  enum_attr  :preposition, %w( ^about at_time on_date since beginning beginning_at before and as_well_as in_addition_to along_with together_with in_conjunction_with at_time on_date before prior_to after following since beginning beginning_at dring while at_the_sae_time_as about on in_reference_to concerning regarding in inside within inside_of included_in as_part_of via through by_way_of from by at located_at
                                with_location at_venue at_place and as_well_as in_addition_to along_with together_with in_conjunction_with ) do
     at_time?  %w( at_time on_date )
     before?   %w( before prior_to )
     after?    %w( after following )
     since?    %w( since beginning beginning_at )
     during?   %w( dring while at_the_sae_time_as )
     about?    %w( about on in_reference_to concerning regarding )
     in?       %w( in inside within inside_of included_in as_part_of )
     via?      %w( via through by_way_of from by )
     at?       %w( at located_at with_location at_venue at_place )
     and?      %w( and as_well_as in_addition_to along_with together_with in_conjunction_with )

     references_time?     { at_time? || before? || after? || during? || since? }
     references_object?   { in? || via? || about? }
     references_location? { at? || via? }  # Yes via is both?
  end

  alias :ind :indirect_object

  before_save do
    instantiate_object!(:indirect_object) unless !indirect_object.blank?
  end

  def has_indirect_object?
    (self.indirect_object.present? && self.indirect_object[:id].present?) rescue false
  end
  


  #### Time Helpers! ####

  def started_at
    (references_time? && has_indirect_object?) && (ind.started_time rescue nil || ind.started_at rescue nil || ind.created_time rescue nil)
  end

  def started?; started_at.present?; end
  alias :starts_at :started_at
  alias :starts? :started?

  def ended_at
    (references_time? && has_indirect_object?) && (ind.ended_time rescue nil || ind.ended_at rescue nil || ind.created_time rescue nil)
  end

  def ended?; ended_at.present?; end
  alias :ends_at :ended_at
  alias :ends? :ended?

  def now
    @now ||= Time.now
  end

  def active?
    (started? && !ended?) rescue nil
  end
  alias :ongoing? :active?

  # Returning anything here is misleading.  Maybe nil?
  def ended?
    (started_at < now && ended_at > now) rescue nil
  end
  alias :over? :ended?

  def started?
    (started_at < now) rescue nil
  end

end
