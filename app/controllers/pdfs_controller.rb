class PdfsController < ApplicationController
  
  def metadata
    render json: generate_pdf_metadata(params[:urls])
  end

  private

  def generate_pdf_metadata(urls)
    return {} unless urls.is_a?(Array)

    Tempfile.create(['temp_file', '.pdf']) do |file|
      file.binmode
      file.write(
        $docraptor.create_doc(
          test: true,
          document_url: urls[0],
          name: 'docraptor-ruby.pdf',
          type: 'pdf'
        )
      )

      pdf_reader = PDF::Reader.new(file)

      {
        url: urls[0],
        version: pdf_reader.pdf_version,
        info: pdf_reader.info,
        metadata: pdf_reader.metadata,
        page_count: pdf_reader.page_count
      }
    end
  end
end
