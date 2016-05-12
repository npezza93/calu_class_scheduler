class CurriculumCategoriesController < ApplicationController
  before_action :set_category, except: [:create, :new, :index]
  before_action :set_major
  authorize_resource

  def index
    @courses = Course.all.order(:subject)
  end

  def show
  end

  def new
    @category = CurriculumCategory.new
    @category_sets = @category.curriculum_category_sets.build
    @course_sets = @category.course_sets.build
    @courses = Course.all.order(:subject)
  end

  def edit
    @courses = Course.all.order(:subject)
  end

  def create
    @category = CurriculumCategory.new(category_params)

    if @category.save
      redirect_to curriculum_categories_path,
                  notice: @category.category + ' has been created!'
    else
      @courses = Course.all.order(:subject)
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to curriculum_categories_url,
                  notice: @category.category + ' successfully updated!'
    else
      @courses = Course.all.order(:subject)
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to curriculum_categories_url,
                notice: @category.category + ' successfully deleted!'
  end

  private

  def set_category
    @category = CurriculumCategory.includes(curriculum_category_sets: :courses)
                                  .find(params[:id])
  end

  def set_major
    @major = current_user.major
  end

  def category_params
    params.require(:curriculum_category).permit(
      :category, :minor, :set_and_or_flag,
      curriculum_category_sets_attributes: [
        :id, :count, :_destroy, course_sets_attributes:
          [:id, :course_id, :_destroy]
      ]
    ).merge(major_id: current_user.major_id)
  end
end
