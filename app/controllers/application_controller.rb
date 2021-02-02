class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  # code actions here!
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end 

  post '/recipes' do
    @recipe = Recipe.create(:name => params[:name], :cook_time => params[:cook_time], :ingredients => params[:ingredients])
    redirect to "/recipes/#{@recipe[:id]}"
  end

  get '/recipes/:id/edit' do
    current_recipe(params[:id])
    erb :edit
  end

  get "/recipes/:id" do
    current_recipe(params[:id])
    erb :recipe
  end

  patch "/recipes/:id" do
    current_recipe(params[:id])
    @recipe.update(:name => params[:name], :cook_time => params[:cook_time], :ingredients => params[:ingredients])
    erb :recipe
  end

  delete "/recipes/:id" do
    current_recipe(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

  helpers do
    def current_recipe(id)
      @recipe = Recipe.find(id)
    end
  end

end