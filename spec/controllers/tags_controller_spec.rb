require 'spec_helper'

describe TagsController do
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
      response.should have_selector("title", :content => "New Tag")
    end
  end

  describe "GET 'edit'" do
    
    before(:each) do
      @tag = Factory(:tag)
      #sign_in Factory(:user)
    end
    
     it "should be successful" do
      get :edit, :id => @tag
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @tag
      response.should have_selector("title", :content => "Edit tag")
    end
    
    
  end

  describe "PUT 'update'" do
    before(:each) do
      @tag = Factory(:tag)
      #sign_in Factory(:user)
   end
    
    describe "failure" do
      before(:each) do
        @attr = { :name => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @tag, :tag => @attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => @tag, :tag => @attr
        response.should have_selector("title", :content => "Edit tag")
      end
      
    end
    
    describe "success" do
      before(:each) do
        @attr = { :name => "Something" }
      end
      
      it "should change the tag's attributes" do
        put :update, :id => @tag, :tag => @attr
        tag = assigns(:tag)
        @tag.reload
        @tag.name.should  == tag.name
      end
      
      it "should redirect to the tag show page" do
        put :update, :id => @tag, :tag => @attr
        response.should redirect_to(tag_path(@tag))
      end
      
      it "should have a flash message" do
        put :update, :id => @tag, :tag => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
     
    
  end

=begin
  describe "authentication of tag edit/update pages" do

    before(:each) do
      @tag = Factory(:tag)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @tag
        response.should redirect_to(new_user_session_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @tag, :tag => {}
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
      @tag = Factory(:tag)
    end
    
    it "should be successful" do
      get :show, :id => @tag
      response.should be_success
    end
    
    it "should find the right tag" do
      get :show, :id => @tag
      assigns(:tag).should == @tag
    end
    
    it "should have the right title" do
      get :show, :id => @tag
      response.should have_selector("title", :content => @tag.name)    
    end
    
    it "should include the tag in the body" do
      get :show, :id => @tag
      response.should have_selector("h1", :content => @tag.name)
    end
  
  end

  describe "POST 'create'" do
      describe "failure" do

        before(:each) do
        #sign_in Factory(:user)
         @attr = { :name => ""} 
        end

        it "should not create a tag" do
          lambda do
            post :create, :tag => @attr
          end.should_not change(Tag, :count)
        end

        it "should have the right title" do
          post :create, :tag => @attr
          response.should have_selector("title", :content => "New Tag")
        end

        it "should render the 'new' page" do
          post :create, :tag => @attr
          response.should render_template('new')
        end   

      end

      describe "success" do

        before(:each) do
        #sign_in Factory(:user)
         @attr = { :name => "fave page" } 
        end

        it "should create a tag" do
          lambda do
            post :create, :tag => @attr
          end.should change(Tag, :count).by(1)
        end

        it "should redirect to the tag show page" do
          post :create, :tag => @attr
          response.should redirect_to(tag_path(assigns(:tag)))
        end   
        
        it "should have a flash message" do
          post :create, :tag => @attr
          flash[:success].should =~ /Tag created successfully/
        end

      end

  end
  
  describe "DELETE 'destroy'" do
  end

end
