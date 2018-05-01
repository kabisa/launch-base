describe "/ping" do
  it "renders 'pong'" do
    get "/ping"
    expect(response).to be_success
    expect(response.body).to eq "pong"
  end
end
