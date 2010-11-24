class CreateEngrelTables < ActiveRecord::Migration
  def self.up
    create_table :engrel_sentences, :force => true do |t|
      t.column :subject_id, "BIGINT"
      t.column :subject_type, :string 

      t.column :direct_object_id, "BIGINT"
      t.column :direct_object_type, :string 

      t.enum :verb
      t.string :direct_object_data

      t.datetime :created_at
      t.datetime :updated_at
    end     

    add_index :engrel_sentences, :direct_object_id, :name => "direct_object_index"
    add_index :engrel_sentences, :subject_id, :name => "subject_index"
    add_index :engrel_sentences, :verb, :name => "verb_index"
    change_column :engrel_sentences, :id, 'BIGINT NOT NULL AUTO_INCREMENT'  # For big IDs like Facebook

    create_table :engrel_prepositional_phrases, :force => true do |t|
      t.references :sentence

      t.enum :preposition
      t.enum :modifier

      t.column :indirect_object_id, "BIGINT"
      t.column :indirect_object_type, :string

      t.string :indirect_object_data

      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :engrel_prepositional_phrases, :indirect_object_id, :name => "indirect_object_index"
    add_index :engrel_prepositional_phrases, :preposition, :name => "preposition_index"
    change_column :engrel_prepositional_phrases, :id, 'BIGINT NOT NULL AUTO_INCREMENT'
  end

  def self.down
    drop_table :engrel_sentences
    drop_table :engrel_prepositional_phrases
  end

end
