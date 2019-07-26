Rails.application.routes.draw do
  root 'front#index'

  #carousel_configurations routes
  draw :carousel_configurations

  #case_causes routes
  draw :case_causes
end
