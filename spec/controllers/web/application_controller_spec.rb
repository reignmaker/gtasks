require 'rails_helper'

describe Web::ApplicationController, type: :controller do

  controller do
    def show
      raise ActiveRecord::RecordNotFound
    end
  end

  describe "handling record NotFound exceptions" do
    it "returns 404 status" do
      get :show, id: 1
      expect(response.status).to be(404)
    end
    it "renders public/404.html template file" do
      get :show, id: 1
      expect(response).to render_template(file: Rails.root.join('public/404.html').to_s)
    end
  end
end
