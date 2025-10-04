class SampleController < ApplicationController
  def index
    render json: { message: "Hello, this is a sample API response!" }
  end
end
