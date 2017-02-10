# require 'byebug'
require_relative 'db_connection'
require 'active_support/inflector'

class SQLObject
  def self.columns
    return @columns unless @columns.nil?

    query = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM #{self.table_name}
    SQL

    @columns = query.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method("#{col}=") do |value|
        self.attributes
        @attributes[col] = value
      end

      define_method(col) do
        self.attributes
        @attributes[col]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    all = DBConnection.execute(<<-SQL)
    SELECT
      *
    FROM #{self.table_name}
    SQL

    parse_all(all)
  end

  def self.parse_all(results)
    results.map do |result|
      self.new(result)
    end
  end

  def self.find(id)
    target = DBConnection.execute(<<-SQL, id)
    SELECT
      *
    FROM  #{table_name}
    WHERE id = ?
    SQL

    target.empty? ? nil : self.new(target.first)
  end

  def initialize(params = {})
    params.each do |attr_name, val|
      attr_name = attr_name.to_sym
      if self.class.columns.include?(attr_name)
        self.send("#{attr_name}=", val)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |column|
      self.send(column.to_s)
    end

  end

  def insert
    column_num = self.class.columns.length - 1
    cols = self.class.columns[1..-1].join(", ")
    q_marks = (["?"] * column_num).join(", ")
    col_vals = self.attribute_values[1..-1]
    # debugger
    DBConnection.execute(<<-SQL, *col_vals)
    INSERT INTO
      #{self.class.table_name} (#{cols})
    VALUES
      (#{q_marks})
    SQL

    # debugger
    self.id = DBConnection.last_insert_row_id
  end

  def update
    # debugger
    column_num = self.class.columns.length - 1
    cols = questionify(self.class.columns)[1..-1].join(", ")
    # col_vals = self.attribute_values[1..-1]

    DBConnection.execute(<<-SQL, self.id)
    UPDATE
      #{self.class.table_name}
    SET
      #{cols}
    WHERE
      id = ?
    SQL
  end

  def save
    self.id.nil? ? self.insert : self.update
  end

  private
  def questionify(arr)
    arr.map.with_index do |c, idx|
      "#{c} = '#{attributes[c]}'"
    end
  end

end
