# frozen_string_literal: true
class CurriculumCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_major
  before_action :set_category, except: [:create, :new, :index]
  before_action :set_courses, only: [:new, :create, :edit, :update]
  authorize_resource

  def show
  end

  def new
    @category = @major.categories.new
  end

  def edit
  end

  def create
    @category = CurriculumCategory.new(category_params)

    if @category.save
      redirect_to major_curriculum_category_path(@major, @category),
                  notice: "Category was successfully created!"
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to major_curriculum_category_path(@major, @category),
                  notice: "Category was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to @major, notice: "Category was successfully deleted!"
  end

  private

  def set_category
    @category = @major.categories.includes(
      curriculum_category_sets: :courses
    ).find(params[:id])
  end

  def set_major
    @major = Major.find(params[:major_id])
  end

  def set_courses
    @courses ||= Course.order(:subject)
  end

  def category_params
    params.require(:curriculum_category).permit(
      :category, :minor, :set_and_or_flag,
      curriculum_category_sets_attributes: [
        :id, :count, :_destroy, course_ids: []
      ]
    )
  end
end
