require 'singleton'
require 'sqlite3'
require 'active_support/inflector'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class ModelBase

  def self.table
    ActiveSupport::Inflector.tableize(self.itself.to_s) #'User' -> users
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM #{self.table}
      WHERE id = ?
    SQL

    self.new(data.first)
  end

  def self.all
    #select * from self.table
    data = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
    *
    FROM #{self.table}
    SQL

    data.map { |datum| self.new(datum) }
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, "#{inst_variable_string(", ", true, true)}")
      INSERT INTO
        #{self.table}(#{inst_variable_string(", ", false, true)})
      VALUES
        (#{self.instance_variables.map { |ivar| "?" }.join(", ")})
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, "#{inst_variable_string(", ", true, true)}", @id)
      UPDATE
        users
      SET
        #{inst_variable_string(" = ?, ", true, false)}
      WHERE
        id = ?
      SQL
    end
  end

  def inst_variable_string(separator, at, delete_last)
    result = ""
    self.instance_variables.each do |ivar|
      if at
        result += ivar.to_s + separator unless ivar == :@id
      else
        result += ivar.to_s[1..-1] + separator unless ivar == :@id
      end
    end
    if delete_last
      result[0..-separator.length - 1]
    else
      result[0..-3]
    end
  end

  def self.where(options)
    data = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      self.table
    WHERE #{where_string(options)}
    SQL
    data.map { |datum| self.new(datum) }
  end

  def where_string(options)
    result = ""
    options.each do |k, v|
      result += "#{k} = #{v} AND "
    end
    result[0..-6]
  end
end


class User < ModelBase
  attr_accessor :fname, :lname

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM users
      WHERE fname = ? AND lname = ?
    SQL
    user.map { |u| User.new(u) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    question_likes = QuestionsDatabase.instance.execute(<<-SQL, @id)

    SELECT
      COUNT(question_likes.id) * 1.0 / COUNT(DISTINCT(questions.id)) AS average_karma
    FROM
      questions
      LEFT JOIN question_likes ON questions.id = question_likes.question_id
    WHERE questions.author_id = ?
    SQL
    question_likes.first['average_karma']
  end
end

class Question < ModelBase
  attr_accessor :title, :body, :author_id

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def self.find_by_author_id(author_id)
    question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE author_id = ?
    SQL
    question.map { |q| Question.new(q) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_subject_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
      INSERT INTO
        questions(title, body, author_id)
      VALUES
        (?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, author_id = ?
      WHERE
        id = ?
      SQL
    end
  end

end

class QuestionFollow
  attr_accessor :user_id, :question_id

  def self.find_by_id(id)
    question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_follows
    WHERE id = ?
    SQL
    QuestionFollow.new(question_follow.first)
  end

  def self.followers_for_question_id(question_id)
    question_follow = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      question_follows
      JOIN users ON question_follows.user_id = users.id
    WHERE question_id = ?
    SQL
    question_follow.map { |qf| User.new(qf) }
  end

  def self.followed_questions_for_user_id(user_id)
    question_follow = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      question_follows
      JOIN questions ON question_follows.question_id = questions.id
    WHERE user_id = ?
    SQL
    question_follow.map { |qf| Question.new(qf) }
  end

  def self.most_followed_questions(n)
    question_follow = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM questions
    JOIN question_follows on questions.id = question_follows.question_id
    GROUP BY question_follows.question_id
    ORDER BY count(question_follows.question_id) DESC
    LIMIT ?
    SQL

    question_follow.map { |q| Question.new(q) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end

class Reply < ModelBase
  attr_accessor :subject_id, :parent_id, :user_id, :body

  def self.find_by_user_id(user_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE user_id = ?
    SQL
    reply.map { |r| Reply.new(r) }
  end

  def self.find_by_subject_id(subject_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, subject_id)
    SELECT
      *
    FROM
      replies
    WHERE subject_id = ?
    SQL
    reply.map { |r| Reply.new(r) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @subject_id = options['subject_id']
    @parent_id = options['parent_id']
    @body = options['body']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@subject_id)
  end

  def parent_reply
    return nil if @parent_id.nil?
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    reply = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE parent_id = ?
    SQL
    reply.map { |r| Reply.new(r) }
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @subject_id, @parent_id, @user_id, @body)
      INSERT INTO
        replies(subject_id, parent_id, user_id, body)
      VALUES
        (?, ?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, @subject_id, @parent_id, @user_id, @body, @id)
      UPDATE
        replies
      SET
        subject_id = ?, parent_id = ?, user_id = ?, body = ?
      WHERE
        id = ?
      SQL
    end
  end
end

class QuestionLike
  attr_accessor :user_id, :question_id

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
    users.*
    FROM users
    JOIN question_likes on users.id = question_likes.user_id
    WHERE question_likes.question_id = ?
    SQL

    likers.map { |l| User.new(l) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM questions
    JOIN questions_likes on questions.id = question_likes.question_id
    ORDER BY count(question_likes.question_id)
    LIMIT ?
    SQL

    questions.map { |q| Question.new(q) }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
    count(*)
    FROM users
    JOIN question_likes on users.id = question_likes.user_id
    WHERE question_likes.question_id = ?
    SQL

    num_likes.first["count(*)"]
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
    questions.*
    FROM questions
    JOIN question_likes on question_likes.question_id = questions.id
    WHERE question_likes.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.find_by_id(id)
    question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE id = ?
    SQL
    QuestionLike.new(question_like.first)
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
