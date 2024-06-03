# spec/support/view_rendering.rb

RSpec.configure do |config|
  config.before(:each, type: :controller) do
    allow(controller).to receive(:render).and_call_original
  end
end
