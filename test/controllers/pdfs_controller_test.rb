require 'test_helper'

class PdfsControllerTest < ActionDispatch::IntegrationTest

  test '#metadata returns an object grouped by page_count and sorted by url' do
    return_values = [
      { url: 'a', page_count: 3 },
      { url: 'z', page_count: 3 },
      { url: 'b', page_count: 3 },
      { url: 'c', page_count: 2 }
    ]

    WebsiteToPdfMetadata.stub(:call, proc { return_values.shift }) do
      get '/pdf_metadata?urls[]=a&urls[]=z&urls[]=b&urls[]=c'
      data = JSON.parse(@response.body)
      
      assert_response :success

      assert_equal(data['2'].length, 1)
      assert_equal(data['3'].length, 3)
      assert_equal(data['3'].first['url'], 'a')
      assert_equal(data['3'].second['url'], 'b')
      assert_equal(data['3'].third['url'], 'z')
    end
  end
end
