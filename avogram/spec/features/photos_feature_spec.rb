require 'rails_helper'

feature 'photos' do
  context 'no photos have been added' do
    scenario 'schould display a prompt to add a photo'do
      visit '/photos'
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
      expect(page).to have_content('Avotoast')
      expect(page).not_to have_content('No photos yet!')
    end
  end

  context 'adding photos' do
    scenario 'prompts user to complete form, then displays the new photo' do
      visit '/photos'
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
      click_link 'AVO'
      expect(page).to have_content 'AVO'
      expect(current_path).to eq "/photos/#{avotoast.id}"
    end
  end

  context 'editing photos' do
    before {Photo.create name: 'AVO'}

    scenario 'let a user edit a photos name' do
      visit '/photos'
      click_link 'Edit AVO'
      fill_in 'Name', with: 'Avotoast'
      click_button 'Update Photo'
      expect(page).to have_content 'Avotoast'
      expect(current_path).to eq '/photos'
    end
  end

end
