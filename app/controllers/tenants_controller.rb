class TenantsController < ApplicationController
  before_action :find_tenant, only: [:show, :update, :destroy]

  # /tenants
  def index
    @tenants = Tenant.all
    render json: @tenants
  end

  # /tenants/:id
  def show
    if @tenant
      render json: @tenant
    else
      render json: { errors: ["Tenant not found"] }, status: :bad_request
    end
  end

  # POST /tenants
  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      render json: @tenant, status: :created
    else
      render json: { errors: @tenant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /tenants/:id
  def update
    if @tenant.update(tenant_params)
      render json: @tenant
    else
      render json: { errors: @tenant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /tenants/:id
  def destroy
    if @tenant
      @tenant.destroy
      render json: @tenant
    else
      render json: { errors: ["Tenant not found"] }, status: :bad_request
    end
  end

  private

    def find_tenant
      @tenant = Tenant.find_by_id(params[:id])
    end

    def tenant_params
      params.require(:tenant).permit(:age, :name)
    end
end
