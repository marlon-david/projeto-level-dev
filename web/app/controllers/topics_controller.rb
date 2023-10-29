class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show edit update destroy ] #[ :show, :edit, :update ]

  def index
    @topics = Topic.all
  end

  def show
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to topic_url(@topic), notice: "Tópico criado"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      # flash[:notice] = "Tópico atualizado"
      redirect_to topic_url(@topic), notice: "Tópico atualizado"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @topic.destroy

    redirect_to topics_url, notice: "Tópico removido"
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:titulo)
  end
end