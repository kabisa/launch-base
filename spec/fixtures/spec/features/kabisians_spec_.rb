describe 'Kabisians' do
  2.times do
    it 'is visible on the kabisians page', :js do
      create(:kabisian, name: 'Kamili')

      visit '/kabisians'

      expect(page).to have_content 'Hello, my name is Kamili'
      expect(page).to have_content 'I have 0 colleagues'
    end
  end
end
