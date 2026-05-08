# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Photos', type: :request do
  describe 'GET /photos' do
    context 'when user is not logged in' do
      it 'redirects to the sign in page' do
        get photos_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
