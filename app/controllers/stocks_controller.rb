require "fileutils"
require "securerandom"

class StocksController < ApplicationController
  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)

    if params[:stock][:image].present?
      @stock.image_path = save_uploaded_image(params[:stock][:image])
    end

    if @stock.save
      redirect_to new_stock_path, notice: "Stock data inserted successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:category, :name, :price)
  end

  def save_uploaded_image(uploaded_image)
    filename = [
      SecureRandom.hex(8),
      sanitize_filename(uploaded_image.original_filename)
    ].join("_")

    upload_directory = Rails.root.join("public", "uploads", "stocks")
    FileUtils.mkdir_p(upload_directory)
    File.binwrite(upload_directory.join(filename), uploaded_image.read)

    "/uploads/stocks/#{filename}"
  end

  def sanitize_filename(filename)
    File.basename(filename).gsub(/[^0-9A-Za-z.\-]/, "_")
  end
end
