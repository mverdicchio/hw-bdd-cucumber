require 'rails_helper'
describe MoviesController do
  describe 'searching TMDb' do
    it 'calls the model method that performs TMDb search' do
        expect(Movie).to receive(:find_in_tmdb).with('borat')
        post :search_tmdb, {:search_terms => 'borat'}  
    end
    it 'selects the  new movie template for rendering' do    
        @fake_results = [double('Movie'), double('Movie')]
        expect(Movie).to receive(:find_in_tmdb).with('borat').and_return(@fake_results)
        post :search_tmdb, {:search_terms => 'borat'}
        expect(response).to redirect_to(new_movie_path)
    end

    it 'makes the TMDb search results available to that template' do
        @fake_results = [double('Movie'), double('Movie')]
        allow(Movie).to receive(:find_in_tmdb).with('borat').and_return(@fake_results)
        post :search_tmdb, {:search_terms => 'borat'}
        expect(assigns(:movies)).to eq(@fake_results)
      end
  end
end