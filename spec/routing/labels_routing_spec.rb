require "spec_helper"

describe LabelsController do
  describe "routing" do

    it "routes to #index" do
      get("/labels").should route_to("labels#index")
    end

    it "routes to #new" do
      get("/labels/new").should route_to("labels#new")
    end
    
    it "routes to #create" do
      post("/labels").should route_to("labels#create")
    end

    it "routes to #destroy" do
      delete("/labels/1").should route_to("labels#destroy", :id => "1")
    end

  end
end
