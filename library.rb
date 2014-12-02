
class Book
  attr_reader :author
  attr_reader :title
  attr_reader :id
  attr_reader :status

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = "available"
  end

  def check_out
    if @status == "checked_out"
      false
    else
      @status = "checked_out"
      true
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
      true
    else
      false
    end
  end

end

class Borrower

  attr_reader :name

  def initialize(name)
    @name = name
  end

end

class Library

  attr_reader :borrowed_books
  def initialize(name)
    @available_books = []
    @borrowed_books = []
    @borrowers = {}
    @books = 0
  end

  def books
    @available_books
  end

  def register_new_book(title, author)
    @books += 1
    id = @books
    @available_books << Book.new(title, author, id)
  end


  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    books_borrowed_by_borrower = 0
    @borrowers.values.each do |x|
      if x == borrower
        books_borrowed_by_borrower += 1
      end
    end
    if books_borrowed_by_borrower > 1
      nil
    else
      book = @available_books.select {|book| book.id == book_id}[0]
      @borrowers["#{book_id}"] = borrower
      if @available_books.include? book
        book.check_out
        @borrowed_books << @available_books.slice!(@available_books.index(book))
        book
      else
        nil
      end
    end
  end

  def get_borrower(book_id)
    @borrowers["#{book_id}"].name
  end


  def check_in_book(book)
    if book.status == "checked_out"
      book.check_in
      @available_books << @borrowed_books.slice!(@borrowed_books.index(book))
    end
  end

  def available_books
    @available_books
  end

  def borrowed_books
    @borrowed_books
  end
end
