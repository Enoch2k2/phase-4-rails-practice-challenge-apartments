class ApartmentsController < ApplicationController
  before_action :find_apartment, only: [:show, :update, :destroy]

  # /apartments
  def index
    @apartments = Apartment.all
    render json: @apartments
  end

  # /apartments/:id
  def show
    if @apartment
      render json: @apartment
    else
      render json: { errors: ["Apartment not found"] }, status: :bad_request
    end
  end

  # POST /apartments
  def create
    @apartment = Apartment.new(apartment_params)
    if @apartment.save
      render json: @apartment, status: :created
    else
      render json: { errors: @apartment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /apartments/:id
  def update
    if @apartment.update(apartment_params)
      render json: @Apartment
    else
      render json: { errors: @apartment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /apartments/:id
  def destroy
    if @apartment
      @apartment.destroy
      render json: @apartment
    else
      render json: { errors: ["Apartment not found"] }, status: :bad_request
    end
  end

  private

    def find_apartment
      @apartment = Apartment.find_by_id(params[:id])
    end

    def apartment_params
      params.require(:apartment).permit(:number)
    end
end