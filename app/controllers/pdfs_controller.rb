class PdfsController < ApplicationController
  def metadata
    pdf_metadata = generate_pdf_metadata(params[:urls])
    sorted_metadata = group_and_sort_data(pdf_metadata)

    render json: sorted_metadata.to_h
  end

  private

  def generate_pdf_metadata(urls)
    return [] unless urls.is_a?(Array)

    urls.map do |url|
      WebsiteToPdfMetadata.call(url)
    end
  end

  def group_and_sort_data(data) 
    grouped = data.group_by { |item| item[:page_count] }.sort
    grouped.map do |page_count, data|
      [
        page_count,
        data.sort_by { |item| item[:url] }
      ]
    end
  end
end
