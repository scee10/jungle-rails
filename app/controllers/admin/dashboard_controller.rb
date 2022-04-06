class Admin::DashboardController < ApplicationController
  def show
    @product_total_count = Product.count
    @category_total_count = Category.count 
  end
end
