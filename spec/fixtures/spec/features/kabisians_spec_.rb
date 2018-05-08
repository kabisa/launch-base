describe 'Kabisians' do
  it 'is visible on the kabisians page', :js do
    Kabisian.create!(name: 'Kamili')

    visit '/kabisians'

    expect(page).to have_content 'Hello, my name is Kamili'
    expect(page).to have_content 'I have 0 colleagues'
  end
end
