require 'spec_helper'

describe BundlesController do
 render_views

  describe "GET 'new'" do

    before(:each) do
      @bookmark = Factory(:bookmark)
    end

    it "should have the right title" do
      get :new, :bookmark_id => @bookmark

      response.should be_success
      response.should have_selector("title", :content => "New Bundle")
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @bookmark = Factory(:bookmark)
    end

      describe "failure" do

        before(:each) do
          @attr = { :bookmark_id => @bookmark.id, :tag_id => "" } 
        end

        it "should not create a bundle" do
          lambda do
          post :create, :bookmark_id => @bookmark.id, :bundle => @attr
          end.should_not change(Bundle, :count)
        end

        it "should have the right title" do
          post :create, :bookmark_id => @bookmark.id, :bundle => @attr
          response.should have_selector("title", :content => "New Bundle")
        end

        it "should render the 'new' page" do
          post :create, :bookmark_id => @bookmark.id, :bundle => @attr
          response.should render_template('new')
        end   

      end


      describe "success" do

        before(:each) do
          @tag = Factory(:tag)
          @attr = { :bookmark_id => @bookmark.id, :tag_id => @tag.id } 
        end


        it "should create a bundle" do
          lambda do
            post :create, :bundle => @attr
          end.should change(Bundle, :count).by(1)
        end

        it "should redirect to the bookmark show page" do
          post :create, :bundle => @attr
          response.should redirect_to(bookmark_path(assigns(:bundle)))
        end   
        
        it "should have a flash message" do
          post :create, :bundle => @attr
          flash[:success].should =~ /Bundle created successfully/
        end

      end

  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @tag = Factory(:tag)
      @bookmark = Factory(:bookmark)
      #todo need bundle factory
      @bundle = Bundle.create!(:bookmark_id => @bookmark.id, :tag_id => @tag.id)
   end
    
    describe "success" do

      it "should destroy the bundle" do
        lambda do 
          delete :destroy, :id => @bundle
        end.should change(Bundle, :count).by(-1)
      end

      it "should redirect to the bookmarks show page" do
        delete :destroy, :id => @bundle
        response.should redirect_to(@bundle.bookmark)
      end

    end

  end  


end
