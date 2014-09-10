require 'engrel/mixin'
require 'engrel/prepositional_phrase'

class Engrel::Sentence < ActiveRecord::Base
  # This is the main backbone of Engrel.  A sentence is just a has and belongs to many relation with a verb attached that tells you the nature of the relationship.
  # Prepositional phrases are optional and can make relationships ternary and more specific.  A sentence can have as many prepositional phrases as is appropriate.

  include Engrel::Mixin

  # NOTE: TO non-AR users--this whole top declaration will need changing if you're not using AR.

  # Set the table name so as not to clash with other tables.
  set_table_name "engrel_sentences"

  # Usually a user, since they're the "actors" in most systems.  The "Who" of the sentence.
  belongs_to :subject, :polymorphic => true

  # The thing we're being related with.  The "What" of the sentence, and the recipieit of theeffect of the transitive verb.
  # http://www.chompchomp.com/terms/directobject.htm
  belongs_to :direct_object, :polymorphic => true

  # Prepositions are stored as children.  Each has a preposition and an object (i.e. "beside the chair")
  has_many :prepositional_phrases, :uniq => true

  # There's obviously the possibility that dynamic accessors could be defined to access these "indirect object" so you could say like sentence.well post if the ternary
  # relation was "Bob posted about Mary on his wall", where the post is the indirect object, mary is the direct object, and Bob is the subject.
  has_many :indirect_objects, :through => :prepositional_phrases

  # The verb.  Specifically a transitive verb (it needs two objects).
  # commented_on: Something comments on a direct_object.
  # likes: Something likes a direct_object object.
  # manages: Something manages a page.
  # is_friends_with: A user knows another user.
  # dates: A user dates another user (acts like: knows)
  # is_related_to: A user is related to another user.
  # attended: A user attended an event.
  # worked_for/works_for: User employed by organization.
  # attended/attends: User attends a school.
  # checked_in: A user checks in to a page (through a subject)
  # posted: Something posts an object (photo/video/album/link)
  # messaged: Someone messages someone else.
  # wall_messaged: Something posts on something's wall (about a subject/tagged_in user)
  # subscribes_to: Something subscribes to a feed.
  # write_note: Something wrote a note (about a subject)
  # is: A status message.
  # hosts: Something hosts an event..
  # is_invited_to: A user is invited to an event/group.
  enum_attr :verb, %w(^is_friends_with commented_on likes belongs_to manages dates is_related_to attended
    is_friends_with dates is_related_to worked_for was_employed_by works_for was_laid_off_from founded works_part_time_for attended is_an_avid_alumni teaches_at subscribes_to wall_messaged
    commented_on checked_in tagged_in posted messaged is wrote_note is_invited_to belongs_to worked_for works_for attends attended is_invited_to religiously_attends tagged_in visited
    appears_to_be_having_fun_in is_posing_generically_in attends attended is_invited_to does_not_want_to_attend disliked_the_crowd_at ) do 

    # When the link acts like "knows" relation
    # Facebook-specific verbs
    knows?        %w( is_friends_with dates is_related_to )
    job?          %w( worked_for was_employed_by works_for was_laid_off_from founded works_part_time_for)
    education?    %w( attended is_an_avid_alumni teaches_at)
    subscription? %w( subscribes_to wall_messaged commented_on checked_in tagged_in posted messaged is wrote_note is_invited_to )
    membership?   %w( belongs_to worked_for works_for attends attended is_invited_to religiously_attends )
    tag?          %w( tagged_in visited appears_to_be_having_fun_in is_posing_generically_in )
    event?        %w( attends attended is_invited_to does_not_want_to_attend disliked_the_crowd_at )
  end


  # How we make a new sentence while ensuring an existing one doesn't exist.
  def self.claim(subject, verb, direct_object)
    params = {:subject_type => subject.class.to_s, :subject_id => subject[:id], :direct_object_type => direct_object.class.to_s, :direct_object_id => direct_object[:id], :verb => verb.to_s}.stringify_keys
    s = self.where(params).first
    s = create(params) if s.blank?
    s.reload
    block_given? ? yield(s) : s
  end

  # This describes the relationship of the subject to the fact.
  # You can determine your own meaning for these, but try to document your use as you see fit.
  before_save do
    instantiate_object!(:subject)
    instantiate_object!(:direct_object)
  end

  def object_list
    [ subject, direct_object ].concat(indirect_objects).compact
  end

  def has_subject?
    (self.subject.present? && self.subject[:id].present?) rescue false
  end

  def has_direct_object?
    (self.direct_object.present? && self.direct_object[:id].present?) rescue false
  end

  def verb_enums
    self.enums(:verb)
  end

  def verb_label(element = nil)
    element ||= self.verb
    verb_enums.label(element.to_sym)
  end

  def only(*args)
    self.prepositional_phrases.clear
    prep(*args)
    self
  end

  def prep(prep, indirect_object)
    if self.prepositional_phrases.include?(preposition: prep, indirect_object_id: indirect_object.id, indirect_object_type: indirect_object.class.to_s)
      warn "PREP ALREADY EXISTS!"
    else
      self.prepositional_phrases.create(preposition: prep, indirect_object: indirect_object)
    end
    self
  end

  def to_sentence_colored
    sen = "#{subject_type.humanize}[#{subject.name rescue subject_id}\##{subject_id}]".green +
          " #{verb_label.downcase} " + "#{direct_object_type.humanize}[#{direct_object.name rescue direct_object_id}\##{direct_object_id}]".cyan
    sen += " " unless prepositional_phrases.blank? rescue true
    preps = prepositional_phrases.collect { |p| "#{p.preposition.to_s.humanize.downcase} " + "#{p.indirect_object_type.humanize}[#{p.object.name rescue p.indirect_object_id}\##{p.indirect_object_id}]".yellow }.join(" ") rescue nil
    sen << preps unless preps.blank?
    sen += '.'
    sen
  end

  def to_sentence
    # stripping ANSI is just removing from the pair ESC and [ up 
    # to the lowercase letter m, lazily.
    to_sentence_colored.gsub(/\x1B\[.*?m/, "");
  end
end

