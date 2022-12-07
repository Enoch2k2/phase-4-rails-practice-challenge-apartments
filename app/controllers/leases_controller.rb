class LeasesController < ApplicationController

  def index
    @leases = Lease.all

    render json: @leases
  end

  def create
    @lease = Lease.new(lease_params)
    if @lease.save
      render json: @lease, status: :created
    else
      render json: { errors: @lease.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def lease_params
      params.require(:lease).permit(:apartment_id, :tenant_id, :rent)
    end
end
