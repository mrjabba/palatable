class TagsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @title = "Tag Repository"
    @tags = Tag.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
   end

  def show
    @tag = Tag.find(params[:id])
    @title = "View Tag | " + @tag.name
  end

  def edit
    @tag = Tag.find(params[:id])
    @title = "Edit tag"
  end
  
  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(params[:tag])
      flash[:success] = "Tag updated."
      redirect_to @tag
    else
      @title = "Edit tag"
      render 'edit'
    end    
  end
  
  def new
    @title = "New Tag"
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      flash[:success] = "Tag created successfully!"
      redirect_to @tag
    else 
      @title = "New Tag"
      render 'new'
    end
  end    


  private

    def sort_column
      Tag.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end


end
