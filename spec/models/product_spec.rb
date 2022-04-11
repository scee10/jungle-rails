require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before (:each) do
      @category = Category.new
      @product = Product.new
    end

    it "should save a valid product" do
      @product = Product.new(name: "Apple", category: @category, quantity: 2, price: 100)
      expect(@product).to be_valid
    end

    it "does not save without a valid name" do
      @product.name = nil
      expect(@product).to_not be_valid
    end

    it "does not save without a valid price" do
      @product.price = nil
      expect(@product).to_not be_valid
    end

    it "does not save without a valid quantity" do
      @product.quantity = nil 
      expect(@product).to_not be_valid
    end

    it "does not save without a valid category" do 
      @product.category = nil 
      expect(@product).to_not be_valid
    end

  end
end
