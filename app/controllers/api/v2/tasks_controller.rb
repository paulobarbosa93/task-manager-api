class Api::V2::TasksController < Api::V2::BaseController
  before_action :authenticate_with_token!

  def index
    tasks = current_user.tasks.ransack(params[:q]).result
    render json: tasks
  end

  def show
    task = current_user.tasks.find(params[:id])
    render json: task
  end

  def create
    task = current_user.tasks.build(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors }, status: :unprocessable_entity
    end
  end

  def update
    task = current_user.tasks.find(params[:id])
    if task.update(task_params)
      render json: task
    else
      render json: { errors: task.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    head :no_content
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :done)
  end
end
