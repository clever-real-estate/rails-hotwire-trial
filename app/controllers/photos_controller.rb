class PhotosController < ApplicationController
  def index
    @photos = Photo.all
    # TODO: More photos will require pagination (e.g. Pagy) and use `.includes(:likes)`
    # or a counter_cache to avoid N+1 queries on like counts.
  end
end
