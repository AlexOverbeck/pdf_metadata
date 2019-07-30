class WebsiteToPdfMetadata
  def self.call(*args)
    new(*args).call
  end
  
  def initialize(url)
    @url = url
  end

  def call
    pdf = get_pdf_from_url(@url)

    Tempfile.create(['temp_file', '.pdf']) do |file|
      file.binmode
      file.write(pdf)

      pdf_reader = PDF::Reader.new(file)

      {
        url: @url,
        version: pdf_reader.pdf_version,
        info: pdf_reader.info,
        metadata: pdf_reader.metadata,
        page_count: pdf_reader.page_count
      }
    end
  end

  def get_pdf_from_url(url)
    $docraptor.create_doc(
      test: true,
      document_url: url,
      name: 'docraptor-ruby.pdf',
      type: 'pdf'
    )
  end
end
