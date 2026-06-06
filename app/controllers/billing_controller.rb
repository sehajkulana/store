class BillingController < ApplicationController
  def index
    @categories = Stock.select(:category).distinct.order(:category).pluck(:category)
    @stocks = Stock.order(:category, :name)
  end
end
