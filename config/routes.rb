Rails.application.routes.draw do
  get "/drugs", to: "drugs#index", as: :drugs
  post "/drugs/ask", to: "drugs#ask", as: :ask_ai
  get "/d/:slug", to: "drugs#show", as: :drug
  post "/d/:slug/summarize", to: "drugs#summarize", as: :summarize_drug

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "drugs#index"
end
