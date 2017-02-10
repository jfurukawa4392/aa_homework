require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params.map do |k, v|
      "#{k} = ?"
    end.join(' AND ')

    results = DBConnection.execute(<<-SQL, params.values)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{where_line}
    SQL

    results.map { |el| self.new(el) }
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
