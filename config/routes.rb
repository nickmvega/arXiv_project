Rails.application.routes.draw do
  # Routes for the Papertopic resource:

  # CREATE
  post("/insert_papertopic", { :controller => "papertopics", :action => "create" })
          
  # READ
  get("/papertopics", { :controller => "papertopics", :action => "index" })
  
  get("/papertopics/:path_id", { :controller => "papertopics", :action => "show" })
  
  # UPDATE
  
  post("/modify_papertopic/:path_id", { :controller => "papertopics", :action => "update" })
  
  # DELETE
  get("/delete_papertopic/:path_id", { :controller => "papertopics", :action => "destroy" })

  #------------------------------

  # Routes for the Topic resource:

  # CREATE
  post("/insert_topic", { :controller => "topics", :action => "create" })
          
  # READ
  get("/topics", { :controller => "topics", :action => "index" })
  
  get("/topics/:path_id", { :controller => "topics", :action => "show" })
  
  # UPDATE
  
  post("/modify_topic/:path_id", { :controller => "topics", :action => "update" })
  
  # DELETE
  get("/delete_topic/:path_id", { :controller => "topics", :action => "destroy" })

  #------------------------------

  # Routes for the Paper resource:

  # CREATE
  post("/insert_paper", { :controller => "papers", :action => "create" })
          
  # READ
  get("/papers", { :controller => "papers", :action => "index" })
  
  get("/papers/:path_id", { :controller => "papers", :action => "show" })
  
  # UPDATE
  
  post("/modify_paper/:path_id", { :controller => "papers", :action => "update" })
  
  # DELETE
  get("/delete_paper/:path_id", { :controller => "papers", :action => "destroy" })

  #------------------------------

  devise_for :users
  root "papers#index"
  
end
