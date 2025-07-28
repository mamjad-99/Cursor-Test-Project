class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.order(id: :asc)
    
    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    
    if @order.save
      respond_to do |format|
        format.html { redirect_to orders_path, notice: 'Order created successfully!' }
        format.json { render json: { 
          success: true, 
          message: 'Order created successfully!',
          order: @order.as_json(only: [:id, :customer_name, :freight, :ship_name, :ship_country])
        } }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { 
          success: false, 
          message: 'Failed to create order',
          errors: @order.errors.full_messages 
        }, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      respond_to do |format|
        format.html { redirect_to @order, notice: 'Order updated successfully!' }
        format.json { render json: { 
          success: true, 
          message: 'Order updated successfully!',
          order: @order.as_json(only: [:id, :customer_name, :freight, :ship_name, :ship_country])
        } }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { 
          success: false, 
          message: 'Failed to update order',
          errors: @order.errors.full_messages 
        }, status: :unprocessable_entity }
      end
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to @order, alert: 'Error updating order' }
      format.json { render json: { 
        success: false, 
        message: 'Error updating order: ' + e.message
      }, status: :internal_server_error }
    end
  end

  def destroy
    if @order.destroy
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Order deleted successfully!' }
        format.json { render json: { 
          success: true, 
          message: 'Order deleted successfully!' 
        } }
      end
    else
      respond_to do |format|
        format.html { redirect_to orders_url, alert: 'Failed to delete order' }
        format.json { render json: { 
          success: false, 
          message: 'Failed to delete order' 
        }, status: :unprocessable_entity }
      end
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to orders_url, alert: 'Error deleting order' }
      format.json { render json: { 
        success: false, 
        message: 'Error deleting order: ' + e.message
      }, status: :internal_server_error }
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to orders_url, alert: 'Order not found' }
      format.json { render json: { 
        success: false, 
        message: 'Order not found' 
      }, status: :not_found }
    end
  end

  def order_params
    params.require(:order).permit(:customer_name, :freight, :ship_name, :ship_country)
  end
end
