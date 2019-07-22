Rails.application.routes.draw do
  get 'get_all_carousel_texts', to: 'carousel_configuration#index', as: :get_all_carousel_texts
end
