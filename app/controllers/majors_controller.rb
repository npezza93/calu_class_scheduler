# frozen_string_literal: true
class MajorsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @majors = Major.all.order(:major)
  end

  def show
  end

  def new
    @major = Major.new
  end

  def edit
  end

  def create
    @major = Major.new(major_params)

    if @major.save
      redirect_to majors_path, notice: "Major was successfully created"
    else
      render :new
    end
  end

  def update
    if @major.update(major_params)
      redirect_to majors_path, notice: "Major was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @major.destroy
    redirect_to majors_path, notice: "Major was successfully destroyed"
  end

  private

  def major_params
    params.require(:major).permit(:major)
  end
end
