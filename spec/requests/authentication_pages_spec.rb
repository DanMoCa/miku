require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Ingreso') }
    it { should have_selector('title', text: 'Ingreso') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Iniciar Sesion" }

      it { should have_selector('title', text: 'Ingreso') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Inicio" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Iniciar Sesion"
      end

      it { should have_selector('title', text: user.name) }
      it { should have_link('Perfil', href: user_path(user)) }
      it { should have_link('Cerrar Sesion', href: signout_path) }
      it { should_not have_link('Cerrar Sesion', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Cerrar Sesion" }
        it { should have_link('Iniciar Sesion') }
      end
    end
  end
end