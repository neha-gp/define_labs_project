class AuthorsController < ApplicationController
  before_action :set_author, only: [:edit, :update, :show, :destroy]
 
  def index
   @authors = Author.all
  end
  
  def show
		@author = Author.find(params[:id])
	end


  def new
		@author = Author.new
		
	end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  @author = Author.find(params[:id])
   if @author.update(author_params)
   flash[:notice] = "Author was updated"
   redirect_to author_path(@author)
   else
   flash[:notice] = "Author was not updated"
   render 'edit'
   end
end

  def destroy
  @author = Author.find(params[:id])
  @author.destroy
  flash[:notice] = "Author was deleted"
  redirect_to authors_path
  end

  private

	def author_params
  params.require(:author).permit(:first_name, :last_name, :date_of_birth)
  end

  def set_author
   @author = Author.find(params[:id])
  end
end

