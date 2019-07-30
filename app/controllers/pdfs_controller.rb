class PdfsController < ApplicationController
  def metadata
    render json: generate_pdf_metadata(params[:urls])
  end

  private

  def generate_pdf_metadata(urls)
    return [] unless urls.is_a?(Array)

    urls.map do |url|
      WebsiteToPdfMetadata.call(url)
    end
  end
end
