require 'spec_helper'

describe BookmarksController do
 render_views

  describe "GET 'new'" do

    before(:each) do
      #sign_in Factory(:user)
    end

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "New Bookmark")
    end
  end

  describe "GET 'edit'" do
    
    before(:each) do
      @bookmark = Factory(:bookmark)
      #sign_in Factory(:user)
    end
    
     it "should be successful" do
      get :edit, :id => @bookmark
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @bookmark
      response.should have_selector("title", :content => "Edit bookmark")
    end
    
    
  end

  describe "PUT 'update'" do
    before(:each) do
      @bookmark = Factory(:bookmark)
      #sign_in Factory(:user)
   end
    
    describe "failure" do
      before(:each) do
        @attr = { :title => "", :url => "", :notes => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @bookmark, :bookmark => @attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => @bookmark, :bookmark => @attr
        response.should have_selector("title", :content => "Edit bookmark")
      end
      
    end
    
    describe "success" do
      before(:each) do
        @attr = { :title => "Something", :url => "http://foooo.com", :notes => "stuff things" }
      end
      
      it "should change the bookmark's attributes" do
        put :update, :id => @bookmark, :bookmark => @attr
        bookmark = assigns(:bookmark)
        @bookmark.reload
        @bookmark.title.should  == bookmark.title
        @bookmark.url.should  == bookmark.url
        @bookmark.notes.should  == bookmark.notes
      end
      
      it "should redirect to the bookmark show page" do
        put :update, :id => @bookmark, :bookmark => @attr
        response.should redirect_to(bookmark_path(@bookmark))
      end
      
      it "should have a flash message" do
        put :update, :id => @bookmark, :bookmark => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
     
    
  end

=begin
  describe "authentication of bookmark edit/update pages" do

    before(:each) do
      @bookmark = Factory(:bookmark)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @bookmark
        response.should redirect_to(new_user_session_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @bookmark, :bookmark => {}
        response.should redirect_to(new_user_session_path)
      end
    end
  end  
=end  
  
  describe "GET 'index'" do
  
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should handle paging"

    it "should handle sorting"

    it "should handle simple search"

    it "should case insensitive search on heroku"

  end

  describe "GET 'show'" do
  
    before(:each) do
      @bookmark = Factory(:bookmark)
    end
    
    it "should be successful" do
      get :show, :id => @bookmark
      response.should be_success
    end
    
    it "should find the right bookmark" do
      get :show, :id => @bookmark
      assigns(:bookmark).should == @bookmark
    end
    
    it "should have the right title" do
      get :show, :id => @bookmark
      response.should have_selector("title", :content => @bookmark.title)    
    end
    
    it "should include the bookmark in the body" do
      get :show, :id => @bookmark
      response.should have_selector("h1", :content => @bookmark.title)
    end
  
  end

  describe "POST 'create'" do
      describe "failure" do

        before(:each) do
        #sign_in Factory(:user)
         @attr = { :title => "", :url => "", :notes => "" } 
        end

        it "should not create a bookmark" do
          lambda do
            post :create, :bookmark => @attr
          end.should_not change(Bookmark, :count)
        end

        it "should have the right title" do
          post :create, :bookmark => @attr
          response.should have_selector("title", :content => "New Bookmark")
        end

        it "should render the 'new' page" do
          post :create, :bookmark => @attr
          response.should render_template('new')
        end   

      end

      describe "success" do

        before(:each) do
        #sign_in Factory(:user)
         @attr = { :title => "fave page", :url => "http://zzz.com", :notes => "apples oranges" } 
        end

        it "should create a bookmark" do
          lambda do
            post :create, :bookmark => @attr
          end.should change(Bookmark, :count).by(1)
        end

        it "should redirect to the bookmark show page" do
          post :create, :bookmark => @attr
          response.should redirect_to(bookmark_path(assigns(:bookmark)))
        end   
        
        it "should have a flash message" do
          post :create, :bookmark => @attr
          flash[:success].should =~ /Bookmark created successfully/
        end

      end

  end
  
  describe "DELETE 'destroy'" do
    before(:each) do
      @bookmark = Factory(:bookmark)
   end
    
    describe "success" do

      it "should destroy the bookmark" do
        lambda do 
          delete :destroy, :id => @bookmark
        end.should change(Bookmark, :count).by(-1)
      end

      it "should redirect to the bookmarks show page" do
        delete :destroy, :id => @bookmark
        response.should redirect_to bookmarks_path
      end

    end

  end  

end
