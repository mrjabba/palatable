class BundlesController < ApplicationController

  def new
    @title = "New Bundle"    
    @bundle = Bundle.new(:bookmark_id => params[:bookmark_id])
  end
    
  def create
    @bookmark = Bookmark.find(params[:bundle][:bookmark_id])
    @bundle = Bundle.new(params[:bundle])
    if @bundle.save
      flash[:success] = "Bundle created successfully!"
      redirect_to @bookmark
    else 
      @title = "New Bundle"
      render 'new'
    end
  end    

  def destroy
    @bundle = Bundle.find(params[:id])
    @bundle.destroy
    redirect_to @bundle.bookmark
  end

end
