require 'test_helper'

class PdfsControllerTest < ActionDispatch::IntegrationTest
  test '#metadata returns an empty array if urls are not specified' do
    test_pdf = File.read('test/data/invoice.pdf')

    $docraptor.stub(:create_doc, test_pdf) do
      get "/pdf_metadata"
      data = JSON.parse(@response.body)

      assert_response :success
      assert data.is_a?(Array)
      assert data.length == 0
    end
  end

  test '#metadata returns an array of pdf data objects' do
    test_pdf = File.read('test/data/invoice.pdf')

    $docraptor.stub(:create_doc, test_pdf) do
      get "/pdf_metadata?urls[]=http://some.test.com"
      data = JSON.parse(@response.body)

      assert_response :success
      assert data.is_a?(Array)
      assert data.length == 1
    end
  end

  test '#metadata accepts mutiple urls via the urls param' do
    test_pdf = File.read('test/data/invoice.pdf')

    $docraptor.stub(:create_doc, test_pdf) do
      get "/pdf_metadata?urls[]=http://some.test.com&urls[]=http://some.other.com"
      data = JSON.parse(@response.body)

      assert_response :success
      assert data.is_a?(Array)
      assert data.length == 2
    end
  end
end
