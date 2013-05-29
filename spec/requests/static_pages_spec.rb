require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)     { 'Inicio' }
    let(:page_title)  { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)     { 'Ayuda' }
    let(:page_title)  { 'Ayuda' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)     { 'Informacion' }
    let(:page_title)  { 'Informacion' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)     { 'Contacto' }
    let(:page_title)  { 'Contacto' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Informacion"
    page.should have_selector 'title', text: full_title('Informacion')
    click_link "Ayuda"
    page.should have_selector 'title', text: full_title('Ayuda')
    click_link "Contacto"
    page.should have_selector 'title', text: full_title('Contacto')
    click_link "Inicio"
    click_link "Registrate!"
    page.should have_selector 'title', text: full_title('')
    click_link "Ruby App"
    page.should have_selector 'title', text: full_title('')
  end

end