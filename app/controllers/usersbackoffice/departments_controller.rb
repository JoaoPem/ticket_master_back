class Usersbackoffice::DepartmentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_department, only: %i[show update destroy]

  def index
    @departments = Department.all
    render json: @departments
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      render json: { message: "Department created successfully", department: @department }, status: :created
    else
      render json: { errors: @department.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @department
  end

  def update
    if @department.update(department_params)
      render json: @department
    else
      render json: @department.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @department.destroy
    head :no_content
  end

  private

  def department_params
    params.require(:department).permit(:name)
  end

  def set_department
    @department = Department.find(params[:id])
  end
end
