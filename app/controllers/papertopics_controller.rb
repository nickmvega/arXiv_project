class PapertopicsController < ApplicationController
  def index
    matching_papertopics = Papertopic.all

    @list_of_papertopics = matching_papertopics.order({ :created_at => :desc })

    render({ :template => "papertopics/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_papertopics = Papertopic.where({ :id => the_id })

    @the_papertopic = matching_papertopics.at(0)

    render({ :template => "papertopics/show" })
  end

  def create
    the_papertopic = Papertopic.new
    the_papertopic.topic_id = params.fetch("query_topic_id")
    the_papertopic.paper_id = params.fetch("query_paper_id")

    if the_papertopic.valid?
      the_papertopic.save
      redirect_to("/papertopics", { :notice => "Papertopic created successfully." })
    else
      redirect_to("/papertopics", { :alert => the_papertopic.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_papertopic = Papertopic.where({ :id => the_id }).at(0)

    the_papertopic.topic_id = params.fetch("query_topic_id")
    the_papertopic.paper_id = params.fetch("query_paper_id")

    if the_papertopic.valid?
      the_papertopic.save
      redirect_to("/papertopics/#{the_papertopic.id}", { :notice => "Papertopic updated successfully."} )
    else
      redirect_to("/papertopics/#{the_papertopic.id}", { :alert => the_papertopic.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_papertopic = Papertopic.where({ :id => the_id }).at(0)

    the_papertopic.destroy

    redirect_to("/papertopics", { :notice => "Papertopic deleted successfully."} )
  end
end
