Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations',
                 passwords: 'users/passwords'
             }

  resources :pages
  resources :file_uploads
  get 'download/:file_name(.:format)' => 'file_uploads#download', as: 'download_file_upload'

  scope :blog, as: :blog do
    get '/' => 'pages#blog'
    get '/:id' => 'pages#show', as: :post
  end

  get 'welcome' => 'welcome#index'

  root 'pages#blog'
end
