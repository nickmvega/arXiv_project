class PapersController < ApplicationController
  def index
    if params[:topic_ids].present?
      topic_ids = params[:topic_ids].map(&:to_i)
      @list_of_papers = Paper.joins(:topics).where(topics: { id: topic_ids }).distinct.order(created_at: :desc)
    else
      @list_of_papers = Paper.order(created_at: :desc)
    end

    render({ :template => "papers/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_papers = Paper.where({ :id => the_id })

    @the_paper = matching_papers.at(0)

    render({ :template => "papers/show" })
  end

  def create
    the_paper = Paper.new
    the_paper.title = params.fetch("query_title")
    the_paper.author = params.fetch("query_author")
    the_paper.arxiv_identifier = params.fetch("query_arxiv_identifier")
    the_paper.url = params.fetch("query_url")
    the_paper.text = params.fetch("query_text")
    the_paper.user_id = current_user.id

    if the_paper.valid?
      if the_paper.save
        if params[:topic_ids].present?
          params[:topic_ids].each do |topic_id|
            Papertopic.create(paper_id: the_paper.id, topic_id: topic_id)
          end
        end
        redirect_to("/papers", { notice: "Paper created successfully." })
      else
        redirect_to("/papers", { alert: the_paper.errors.full_messages.to_sentence })
      end
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_paper = Paper.where({ :id => the_id }).at(0)

    the_paper.title = params.fetch("query_title")
    the_paper.author = params.fetch("query_author")
    the_paper.arxiv_identifier = params.fetch("query_arxiv_identifier")
    the_paper.url = params.fetch("query_url")
    if params[:query_text].present?
      the_paper.text = params.fetch("query_text")
    end

    if the_paper.valid?
      if the_paper.save
        if params[:topic_ids].present?
          selected_topic_ids = params[:topic_ids].map(&:to_i)
          current_topic_ids = the_paper.topics.pluck(:id)
    
          (selected_topic_ids - current_topic_ids).each do |topic_id|
            Papertopic.create(paper_id: the_paper.id, topic_id: topic_id)
          end
    
          (current_topic_ids - selected_topic_ids).each do |topic_id|
            Papertopic.find_by(paper_id: the_paper.id, topic_id: topic_id)&.destroy
          end
        else
          the_paper.papertopics.destroy_all
        end
    
        redirect_to("/papers/#{the_paper.id}", { notice: "Paper updated successfully." })
      else
        redirect_to("/papers/#{the_paper.id}", { alert: the_paper.errors.full_messages.to_sentence })
      end
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_paper = Paper.where({ :id => the_id }).at(0)

    the_paper.destroy

    redirect_to("/papers", { :notice => "Paper deleted successfully."} )
  end
end
