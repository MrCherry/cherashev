require 'rails_helper'

RSpec.describe FileUploadsController, :type => :controller, skip: true do

  # This should return the minimal set of attributes required to create a valid
  # FileUpload. As you add validations to FileUpload, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FileUploadsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all file_uploads as @file_uploads" do
      file_upload = FileUpload.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:file_uploads)).to eq([file_upload])
    end
  end

  describe "GET show" do
    it "assigns the requested file_upload as @file_upload" do
      file_upload = FileUpload.create! valid_attributes
      get :show, {:id => file_upload.to_param}, valid_session
      expect(assigns(:file_upload)).to eq(file_upload)
    end
  end

  describe "GET new" do
    it "assigns a new file_upload as @file_upload" do
      get :new, {}, valid_session
      expect(assigns(:file_upload)).to be_a_new(FileUpload)
    end
  end

  describe "GET edit" do
    it "assigns the requested file_upload as @file_upload" do
      file_upload = FileUpload.create! valid_attributes
      get :edit, {:id => file_upload.to_param}, valid_session
      expect(assigns(:file_upload)).to eq(file_upload)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new FileUpload" do
        expect {
          post :create, {:file_upload => valid_attributes}, valid_session
        }.to change(FileUpload, :count).by(1)
      end

      it "assigns a newly created file_upload as @file_upload" do
        post :create, {:file_upload => valid_attributes}, valid_session
        expect(assigns(:file_upload)).to be_a(FileUpload)
        expect(assigns(:file_upload)).to be_persisted
      end

      it "redirects to the created file_upload" do
        post :create, {:file_upload => valid_attributes}, valid_session
        expect(response).to redirect_to(FileUpload.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved file_upload as @file_upload" do
        post :create, {:file_upload => invalid_attributes}, valid_session
        expect(assigns(:file_upload)).to be_a_new(FileUpload)
      end

      it "re-renders the 'new' template" do
        post :create, {:file_upload => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested file_upload" do
        file_upload = FileUpload.create! valid_attributes
        put :update, {:id => file_upload.to_param, :file_upload => new_attributes}, valid_session
        file_upload.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested file_upload as @file_upload" do
        file_upload = FileUpload.create! valid_attributes
        put :update, {:id => file_upload.to_param, :file_upload => valid_attributes}, valid_session
        expect(assigns(:file_upload)).to eq(file_upload)
      end

      it "redirects to the file_upload" do
        file_upload = FileUpload.create! valid_attributes
        put :update, {:id => file_upload.to_param, :file_upload => valid_attributes}, valid_session
        expect(response).to redirect_to(file_upload)
      end
    end

    describe "with invalid params" do
      it "assigns the file_upload as @file_upload" do
        file_upload = FileUpload.create! valid_attributes
        put :update, {:id => file_upload.to_param, :file_upload => invalid_attributes}, valid_session
        expect(assigns(:file_upload)).to eq(file_upload)
      end

      it "re-renders the 'edit' template" do
        file_upload = FileUpload.create! valid_attributes
        put :update, {:id => file_upload.to_param, :file_upload => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested file_upload" do
      file_upload = FileUpload.create! valid_attributes
      expect {
        delete :destroy, {:id => file_upload.to_param}, valid_session
      }.to change(FileUpload, :count).by(-1)
    end

    it "redirects to the file_uploads list" do
      file_upload = FileUpload.create! valid_attributes
      delete :destroy, {:id => file_upload.to_param}, valid_session
      expect(response).to redirect_to(file_uploads_url)
    end
  end

end
