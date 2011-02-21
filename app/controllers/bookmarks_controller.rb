class BookmarksController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @title = "Bookmark Repository"
    @bookmarks = Bookmark.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
   end

  def show
    @bookmark = Bookmark.find(params[:id])
    @title = "View Bookmark | " + @bookmark.title
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    @title = "Edit bookmark"
  end
  
  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update_attributes(params[:bookmark])
      flash[:success] = "Bookmark updated."
      redirect_to @bookmark
    else
      @title = "Edit bookmark"
      render 'edit'
    end    
  end
  
  def new
    @title = "New Bookmark"
    @bookmark = Bookmark.new
  end
  
  def create
    @bookmark = Bookmark.new(params[:bookmark])
    if @bookmark.save
      flash[:success] = "Bookmark created successfully!"
      redirect_to @bookmark
    else 
      @title = "New Bookmark"
      render 'new'
    end
  end    

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to bookmarks_path
  end

  private

    def sort_column
      Bookmark.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end


end
