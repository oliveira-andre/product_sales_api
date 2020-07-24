# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :alexa, only: %i[], params: :skill_name do
        resources :skills, only: :index
      end
    end
  end
end
