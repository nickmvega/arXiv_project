class BookmarksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @list_of_bookmarks = current_user.bookmarks.includes(:paper).order(created_at: :desc)
    render({ :template => "bookmarks/index" })
  end

  def show
    @the_bookmark = current_user.bookmarks.find_by(id: params.fetch(:path_id))
    render({ template: "bookmarks/show" })
  end

  def create
    the_bookmark = Bookmark.new
    the_bookmark.paper_id = params.fetch("query_paper_id")
    the_bookmark.user_id = current_user.id
    the_bookmark.comment = params.fetch(:query_comment, "N/A")

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks", { :notice => "Bookmark created successfully." })
    else
      redirect_to("/bookmarks", { :alert => the_bookmark.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bookmark = current_user.bookmarks.where({ :id => the_id }).at(0)
    the_bookmark.comment = params.fetch(:query_comment)

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks/#{the_bookmark.id}", { :notice => "Bookmark updated successfully."} )
    else
      redirect_to("/bookmarks/#{the_bookmark.id}", { :alert => the_bookmark.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_bookmark = current_user.bookmarks.where({ :id => the_id }).at(0)

    the_bookmark.destroy

    redirect_to("/bookmarks", { :notice => "Bookmark deleted successfully."} )
  end
end
