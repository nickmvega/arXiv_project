class PapersController < ApplicationController
  def index
    matching_papers = Paper.all

    @list_of_papers = matching_papers.order({ :created_at => :desc })

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
    the_paper.user_id = params.fetch("query_user_id")
    the_paper.papertopics_count = params.fetch("query_papertopics_count")

    if the_paper.valid?
      the_paper.save
      redirect_to("/papers", { :notice => "Paper created successfully." })
    else
      redirect_to("/papers", { :alert => the_paper.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_paper = Paper.where({ :id => the_id }).at(0)

    the_paper.title = params.fetch("query_title")
    the_paper.author = params.fetch("query_author")
    the_paper.arxiv_identifier = params.fetch("query_arxiv_identifier")
    the_paper.url = params.fetch("query_url")
    the_paper.text = params.fetch("query_text")
    the_paper.user_id = params.fetch("query_user_id")
    the_paper.papertopics_count = params.fetch("query_papertopics_count")

    if the_paper.valid?
      the_paper.save
      redirect_to("/papers/#{the_paper.id}", { :notice => "Paper updated successfully."} )
    else
      redirect_to("/papers/#{the_paper.id}", { :alert => the_paper.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_paper = Paper.where({ :id => the_id }).at(0)

    the_paper.destroy

    redirect_to("/papers", { :notice => "Paper deleted successfully."} )
  end
end
