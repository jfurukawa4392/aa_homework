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
    @class_name
  end

  def initialize(name, options = {})
    defaults = {class_name: name.camelcase, primary_key: :id,
                foreign_key: "#{name}_id".to_sym}
    overridden = defaults.merge(options)

    @class_name = overridden[:class_name]
    @primary_key = overridden[:primary_key]
    @foreign_key = overridden[:foreign_key]
  end

  def table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    super(name, options)
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    options[:foreign_key] = "#{self_class_name.downcase.underscore}_id"
                            .to_sym if options[:foreign_key].nil?
    super(name.camelcase.singularize, options)
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    opts = BelongsToOptions.new(name, options)

    define_method(name) do
      fk = opts.send(:foreign_key)
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
  # Mixin Associatable here...
end
