class TasksController < ApplicationController
  before_action :all_tasks, only: [:index, :create, :update, :destroy]
  before_action :upcoming_tasks, only: [:index]
  before_action :set_task, only: [:edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
  end

  def update
    @task.update(task_params)
  end

  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def all_tasks
      @tasks = Task.order(:deadline)
    end

    def upcoming_tasks
      tasks = Task.order(:deadline)
      @upcoming_tasks = []
      tasks.each do |t|
        x = (DateTime.parse("#{t.deadline[6..9]}-#{t.deadline[0..1]}-#{t.deadline[3..4]}") - Time.now.to_datetime).to_i
        if x < 3
          @upcoming_tasks.push(t)
        end
      end
    end

    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :deadline)
    end
end
