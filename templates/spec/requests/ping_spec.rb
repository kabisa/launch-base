describe '/ping' do
  it 'renders "pong"' do
    get '/ping'

    expect(response).to be_successful
    expect(response.body).to eq 'pong'
  end
end
