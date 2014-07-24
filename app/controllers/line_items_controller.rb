class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :decrement, :relative_quantity]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy, :decrement, :relative_quantity]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    session[:counter] = 0

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url }
        format.js   { @current_item = @line_item }
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def relative_quantity
    current_qty = params[:current_qty].to_i
    target_qty = params[:target_qty].to_i

    if @line_item.quantity == current_qty
      if target_qty <= 0
        @line_item.destroy
      else
        @line_item.quantity = target_qty
        @line_item.save
      end
    else
      logger.debug "Quantity update failed, current quantity (#{current_qty}) did not match actual quantity (#{@line_item.quantity})"
    end

    respond_to do |format|
      format.html { redirect_to cart_url(@line_item.cart_id), notice: "Quantity decremented."}
      format.js { render 'decrement.js.erb' }
    end
  end

  def decrement
    if @line_item.quantity == 1
      @line_item.destroy
    else
      @line_item.quantity -= 1
      @line_item.save
    end

    respond_to do |format|
      format.html { redirect_to cart_url(@line_item.cart_id), notice: "Quantity decremented."}
      format.js
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    logger.debug "-- line item destroy --"
    if @line_item.quantity == 1
      @line_item.destroy
    else
      @line_item.quantity -= 1
      @line_item.save
    end
    respond_to do |format|
      format.html { redirect_to cart_url(@line_item.cart_id), notice: "Item removed from cart." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end
