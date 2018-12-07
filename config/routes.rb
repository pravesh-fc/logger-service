Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    post '/logs', to:  "logger#create_log"
    get '/get-data', to: "logger#index"
    post '/create-event', to: "logger#create_event"
  end
end
