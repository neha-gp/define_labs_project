class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :show, :destroy]
 
  def index
    @books = Book.all
  end
  
  def show
	  @book = Book.find(params[:id])
  end

  def new
	  @book = Book.new
    @authors = Author.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    authors = []
    params[:author_id].each do |author_id|
      authors << Author.find(author_id)
    end
    @book = Book.new(book_params)
    
         
    respond_to do |format|
      if @book.save
        @book.authors << authors
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authors = []
    params[:author_id].each do |author_id|
      authors << Author.find(author_id)
    end
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
      @book.authors.destroy_all
      @book.authors << authors
      flash[:notice] = "Book was updated"
      redirect_to book_path(@book)
    else
      flash[:notice] = "Book was not updated"
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book was deleted"
    
    redirect_to books_path
  end

  private

	def book_params
    params.require(:book).permit(:title)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end

