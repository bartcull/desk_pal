require "spec_helper"

describe CasesController do
  describe "routing" do

    it "routes to #index" do
      get("/cases").should route_to("cases#index")
    end

    it "routes to #update_label" do
      patch("/update_label").should route_to("cases#update_label")
    end

  end
end
