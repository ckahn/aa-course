require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name 
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
      foreign_key: "#{name}_id".to_sym,
      primary_key: :id,
      class_name: "#{name.to_s.singularize.camelcase}"
    }

    defaults.merge!(options)

    @foreign_key = defaults[:foreign_key]
    @primary_key = defaults[:primary_key]
    @class_name  = defaults[:class_name]
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      foreign_key: "#{self_class_name.underscore}_id".to_sym,
      primary_key: :id,
      class_name: "#{name.to_s.singularize.camelcase}"
    }

    defaults.merge!(options)

    @foreign_key = defaults[:foreign_key]
    @primary_key = defaults[:primary_key]
    @class_name  = defaults[:class_name]
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions(name, options)
    define_method(name) do
      foreign_key = options.send(:foreign_key)
      model_class = options.send(:model_class)
      primary_key = options.send(:primary_key)
      DBConnection.execute(<<-SQL, foreign_key)
        SELECT
          *
        FROM
          #{table_name}
        WHERE
          id = ?
      SQL
    end
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
