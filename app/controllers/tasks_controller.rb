# タスクコントローラー
class TasksController < ApplicationController
  # タスク一覧を表示
  def index
    @tasks = Task.all
  end

  # 新しいタスクを作成
  def create
    @task = Task.new(task_params)
    
    if @task.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append("tasks", partial: "tasks/task", locals: { task: @task })
        end
      end
    end
  end

  # タスクの完了状態を切り替え
  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@task, partial: "tasks/task", locals: { task: @task })
      end
    end
  end

  # タスクを更新
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@task, partial: "tasks/task", locals: { task: @task })
        end
      end
    end
  end

  # タスクを削除
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@task)
      end
    end
  end

  private

  # タスクのパラメータを取得
  def task_params
    params.require(:task).permit(:text)
  end
end
