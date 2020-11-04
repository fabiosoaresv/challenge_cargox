class FoundatorsController < ApplicationController
  def new
    @companies = Company.all
  end

  def show
  end

  def index
  end
end
