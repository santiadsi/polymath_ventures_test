class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @filterrific = initialize_filterrific(
      Task,
      params[:filterrific],
      persistence_id: false
    ) or return
    @tasks = @filterrific.find.where(user: current_user).page(params[:page]).per_page(10)

    respond_to do |format|
      format.html
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    if @task.user.email != current_user.email
      redirect_to root_path, notice: 'You are not authorized to edit this task'
    end
  end

  # POST /tasks or /tasks.json
  def create
    params[:task][:user_id] = current_user.id
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:description, :complete, :user_id)
  end
end
