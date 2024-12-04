class TopicsController < ApplicationController
  def index
    @list_of_topics = Topic.includes(:papers).order(created_at: :desc)
  end

  def show
    the_id = params.fetch("path_id")
    @the_topic = Topic.find_by(id: the_id)
  
    if @the_topic.nil?
      redirect_to("/topics", { alert: "Topic not found." })
      return
    end
  
    @associated_papers = @the_topic.papers
  end

  def create
    the_topic = Topic.new
    the_topic.topic = params.fetch("query_topic")

    if the_topic.valid?
      the_topic.save
      redirect_to("/topics", { :notice => "Topic created successfully." })
    else
      redirect_to("/topics", { :alert => the_topic.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_topic = Topic.where({ :id => the_id }).at(0)

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
    the_topic = Topic.where({ :id => the_id }).at(0)

    the_topic.destroy

    redirect_to("/topics", { :notice => "Topic deleted successfully."} )
  end
end
