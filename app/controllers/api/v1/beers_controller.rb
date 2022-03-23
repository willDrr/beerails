class Api::V1::BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  def index
    @beers = Beer.all.order(brand: :asc)
    render json: @beers
  end

  def show
    if @beer
      render json: @beer
    else
      render json: @beer.errors
    end
  end

  def new
    @beer = Beer.new
  end

  def edit
  end

  def create
    @beer = Beer.new(beer_params)

    if @beer.save
      render json: @beer
    else
      render json: @beer.errors
    end
  end

  def update
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was sucessfully updated' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @beer.destroy
    render json: { notice: 'Beer was successfully removed' }
  end

  private

  def set_beer
    @beer = Beer.find(params[:id])
  end

  def beer_params
    params.permit(:brand, :style, :country, :quantity)
  end
end
