class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = current_user.merchant.discounts
  end

  def new
  end

  def create
    merchant = current_user.merchant
    discount = merchant.discounts.create(discount_params)
    discount.save
    redirect_to "/merchant/discounts"
    flash[:success] = "Discount #{discount.name} created!"
  end

  private

  def discount_params
    params.permit(:name, :discount_percentage, :minimum_quantity)
  end
end
