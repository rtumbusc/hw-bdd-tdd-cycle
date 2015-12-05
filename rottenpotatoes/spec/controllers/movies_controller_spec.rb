require 'rails_helper.rb'

describe MoviesController do
    describe "#director" do
       context "when specified movie has a director" do
           it "should find movies with same director" do
               #get the movie id from params
               #identify the director
               #call the model to get movies with same director
               #go to new view
               
               @movie_id = '1234'
               @movie = double('fake_movie', :director => 'James Cameron')
               expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
               expect(@movie).to receive(:similar_movies)
               get :director, :id => @movie_id
               expect(response).to render_template(:director)
               
            end
        end
        context "when specified movie doesn't have a director" do
            it "should redirect to the movies page" do
                @movie_id = '1234'
                @movie = double('fake_movie').as_null_object
                expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
                get :director, :id => @movie_id
                expect(response).to redirect_to(movies_path)
            end
        end
    end
    
    
    
end