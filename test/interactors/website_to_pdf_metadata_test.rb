require 'test_helper'

class WebsiteToPdfMetadataTest < ActionDispatch::IntegrationTest
  test 'call returns a pdf data object with expected keys' do
    test_pdf = File.read('test/data/invoice.pdf')

    $docraptor.stub(:create_doc, test_pdf) do
      pdf_data = WebsiteToPdfMetadata.call('http://some.url.com')
      assert_equal(pdf_data.keys, [:url, :version, :info, :metadata, :page_count])
    end
  end
end
