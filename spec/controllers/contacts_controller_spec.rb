require 'rails_helper'

RSpec.describe ContactsController, :type => :controller do

  describe "GET #index" do
    context 'with params[:letter]' do
      it "populates an array of contacts starting with the letter" do
        smith = create(:contact, lastname:'Smith')
        jones = create(:contact, lastname: 'Jones')
        get :index, letter: 'S'
        expect(assigns(:contact)).to match_array([smith])
      end
      it "renders the :index template" do
        get :index, letter: 'S'
        expect(response).to render_template :index
      end
    end
    context 'without params[:letter]' do
      it "populates an array of all contacts" do
        smith = create(:contact, lastname:'Smith')
        jones = create(:contact, lastname: 'Jones')
        get :index
        expect(assigns(:contact)).to match_array([smith,jones])
      end
      it "renders the :index tema" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested contact to @contact" do
      contact = create(:contact)
      get :show, id: contact
      expect(assigns(:contact)).to eq contact 
    end
    it "renders the :show template" do
      contact = create(:contact)
      get :show, id: contact
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new Contact to @contact" do
      get :new
      expect(assigns(:contact)).to be_a_new(Contact)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested contact to @contact" do
      contact = create(:contact)
      get :edit, id: contact
      expect(assigns(:contact)).to eq contact
    end
    it "renders the :edit template" do
      contact = create(:contact)
      get :edit, id: contact
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    before :each do
      @phones = [
        attributes_for(:phone),
        attributes_for(:phone),
        attributes_for(:phone)
      ]
    end
    context 'with valid attributes' do
      it "saves the new contact in the database" do
        expect{
          post :create, contact: attributes_for(:contact, phones_attributes: @phones) 
        }.to change(Contact, :count).by(1)
      end
      it "redirects to contact#show" do
        post :create, contact: attributes_for(:contact, phones_attributes: @phones)
        expect(response).to redirect_to contact_path(assigns[:contact])
      end
    end
    context 'with invalid attributes' do
      it "does not save the new contact in the database" do
        expect{
          post :create, contact: attributes_for(:invalid_contact)
        }.to_not change(Contact, :count)
      end
      it "re-renders the :new template" do
        post :create, contact: attributes_for(:invalid_contact)
        expect(response).to render_template :new
      end
    end
  end
  
  describe "PATCH #update" do
    before :each do
      @contact = create(:contact,
          firstname: 'Lawrence',
          lastname: 'Smith'
        )
    end
    context 'with valid attributes' do
      it "locates the requested @contact" do
        patch :update, id: @contact, contact: attributes_for(:contact)
        expect(assigns(:contact)).to eq(@contact)
      end
      it "changes @contact's attributes" do
        patch :update, id: @contact,
          contact: attributes_for(:contact,
              firstname: 'Larry',
              lastname: 'Smith'
            )
        @contact.reload
        expect(@contact.firstname).to eq('Larry')
        expect(@contact.lastname).to eq('Smith')
      end
      it "redirects to the updated contact" do
        patch :update, id: @contact, contact: attributes_for(:contact)
        expect(response).to redirect_to @contact
      end
    end
    context 'with invalid attributes' do
      it "does not update the contact's attributes" do
        patch :update, id: @contact,
          contact: attributes_for(:contact,
            firstname: 'Larry',
            lastname: nil)
        @contact.reload
        expect(@contact.firstname).to_not eq('Larry')
        expect(@contact.lastname).to eq('Smith')
      end
      it "re-renders the edit template" do
        patch :update, id: @contact, 
          contact: attributes_for(:invalid_contact)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @contact = create(:contact)
    end
    it "deletes the contact from the database" do
      expect{
        delete :destroy, id: @contact
      }.to change(Contact,:count).by(-1)
    end
    it "redirects to users#index" do
      delete :destroy, id: @contact
      expect(response).to redirect_to contacts_url
    end
  end
end
