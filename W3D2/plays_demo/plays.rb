require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    data = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT
      *
      FROM plays
      WHERE title = ?
    SQL
    data.map { |play| Play.new(play) }
  end

  def self.find_by_playwright(name)
    #(returns all plays written by playwright)
    data = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
      *
      FROM plays
      JOIN playwrights on plays.playwright_id = playwrights.id
      WHERE playwrights.name = ?
    SQL
    data.map { |play| Play.new(play) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright

  attr_accessor :name, :birth_year

  def self.all
  end

  def self.find_all_by_name(name)
  end

  def initialize
  end

  def create
  end

  def update
  end

  def get_plays #get_plays (returns all plays written by playwright)
  end
end
