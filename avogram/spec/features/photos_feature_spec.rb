require 'rails_helper'
require_relative 'helpers/session'
include SessionHelpers

feature 'photos' do
  context 'no photos have been added' do
    scenario 'schould display a prompt to add a photo'do
      visit '/photos'
      sign_in
      expect(page).to have_content 'No photos yet!'
      expect(page).to have_link 'Add photo'
    end
  end

  context 'photos have been added' do
    before do
      Photo.create(name: 'Avotoast')
    end

    scenario 'display photos' do
      visit '/photos'
      sign_in
      expect(page).to have_content('Avotoast')
      expect(page).not_to have_content('No photos yet!')
    end
  end

  context 'adding photos' do
    scenario 'prompts user to complete form, then displays the new photo' do
      visit '/photos'
      sign_in
      click_link 'Add photo'
      fill_in 'Name', with: 'Avotoast'
      click_button 'Create Photo'
      expect(page).to have_content 'Avotoast'
      expect(current_path).to eq '/photos'
    end
  end

  context 'viewing photos' do
    let!(:avotoast){Photo.create(name:'AVO')}

    scenario 'lets a user view photos' do
      visit '/photos'
      sign_in
      click_link 'AVO'
      expect(page).to have_content 'AVO'
      expect(current_path).to eq "/photos/#{avotoast.id}"
    end
  end

  context 'editing photos' do
    before {Photo.create name: 'AVO'}

    scenario 'let a user edit a photos name' do
      visit '/photos'
      sign_in
      click_link 'Edit AVO'
      fill_in 'Name', with: 'Avotoast'
      click_button 'Update Photo'
      expect(page).to have_content 'Avotoast'
      expect(current_path).to eq '/photos'
    end
  end

  context 'deleting photos' do
    before {Photo.create name: 'AVO'}

    scenario 'removes a photo when a user click to delete link' do
      visit '/photos'
      sign_in
      click_link 'Delete AVO'
      expect(page).not_to have_content 'AVO'
      expect(page).to have_content 'Photo deleted successfully'
    end
  end


end
