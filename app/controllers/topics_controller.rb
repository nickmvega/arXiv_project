class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @list_of_topics = current_user.topics.order(created_at: :desc)
  end

  def show
    the_id = params.fetch("path_id")
    @the_topic = current_user.topics.find_by(id: the_id)
  
    @associated_papers = @the_topic.papers.where(user: current_user)
  end

  def create
    the_topic = Topic.new
    the_topic.topic = params.fetch("query_topic")
    the_topic.user = current_user

    if the_topic.valid?
      the_topic.save
      redirect_to("/topics", { :notice => "Topic created successfully." })
    else
      redirect_to("/topics", { :alert => the_topic.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_topic = current_user.topics.where({ :id => the_id }).at(0)

    the_topic.topic = params.fetch("query_topic")

    if the_topic.valid?
      the_topic.save
      redirect_to("/topics/#{the_topic.id}", { :notice => "Topic updated successfully."} )
    else
      redirect_to("/topics/#{the_topic.id}", { :alert => the_topic.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_topic = current_user.topics.where({ :id => the_id }).at(0)

    the_topic.destroy

    redirect_to("/topics", { :notice => "Topic deleted successfully."} )
  end
end
